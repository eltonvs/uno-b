MACHINE Uno

SEES Cards, Uno_ctx

ABSTRACT_CONSTANTS
    FST, SND, CAN_PLAY

PROPERTIES
    FST = %(tt, cc) . (tt : CARD_TYPE & cc : COLORS | tt)
    & SND = %(tt, cc) . (tt : CARD_TYPE & cc : COLORS | cc)
    & CAN_PLAY =
        %(t1, c1, t2, c2) .
            (t1 : CARD_TYPE & c1 : COLORS & t2 : CARD_TYPE & c2 : COLORS
                | bool(t1 : WILD or t1 = t2 or c1 = c2))

VARIABLES
    top_card, deck, deck_p1, deck_p2, curr_player, said_uno, started, finished

INVARIANT
    top_card : PLAYABLE_CARDS
    & SND(top_card) /= BLACK
    & deck : seq(CARDS)
    & deck_p1 : seq(CARDS)
    & deck_p2 : seq(CARDS)
    & curr_player : (0..N_PLAYERS-1)
    & said_uno : BOOL
    & started : BOOL
    & finished : BOOL
    & (finished = TRUE => started = TRUE)

INITIALISATION
    top_card :: (CARDS |>> {BLACK})
    || deck :: perm(CARDS)
    || deck_p1 := <>
    || deck_p2 := <>
    || curr_player := 0
    || said_uno := FALSE
    || started := FALSE
    || finished := FALSE

OPERATIONS

cc <-- get_top_card_type = cc := FST(top_card);
cc <-- get_top_card_color = cc := SND(top_card);

draw_card =
    PRE
        started = TRUE & finished = FALSE
        & (curr_player = 0 =>
            !(pt, pc) . (pt : CARD_TYPE & pc : COLORS & (pt, pc) : ran(deck_p1) =>
                CAN_PLAY(pt, pc, FST(top_card), SND(top_card)) = FALSE))
        & (curr_player = 1 =>
            !(pt, pc) . (pt : CARD_TYPE & pc : COLORS & (pt, pc) : ran(deck_p2) =>
                CAN_PLAY(pt, pc, FST(top_card), SND(top_card)) = FALSE))
    THEN
        // Draw the top card from deck
        deck := tail(deck) ||
        IF curr_player = 0
        THEN deck_p1 := deck_p1 <- first(deck)
        ELSE deck_p2 := deck_p2 <- first(deck)
        END ||
        // If the picked up card cannot be played, go to next player
        IF CAN_PLAY(FST(first(deck)), SND(first(deck)), FST(top_card), SND(top_card)) = FALSE
        THEN curr_player := (curr_player + 1) mod N_PLAYERS
        END
    END;

say_uno =
    PRE
        // The game must be started and not finished
        started = TRUE & finished = FALSE
        // User didn't said uno yet
        & said_uno = FALSE
        // User has two cards and at least one is a playable card
        & (curr_player = 0 =>
            size(deck_p1) = 2
            & not(!(pt, pc) . (pt : CARD_TYPE & pc : COLORS & (pt, pc) : ran(deck_p1) =>
                CAN_PLAY(pt, pc, FST(top_card), SND(top_card)) = FALSE)))
        & (curr_player = 1 =>
            size(deck_p2) = 2
            & not(!(pt, pc) . (pt : CARD_TYPE & pc : COLORS & (pt, pc) : ran(deck_p2) =>
                CAN_PLAY(pt, pc, FST(top_card), SND(top_card)) = FALSE)))
    THEN
        said_uno := TRUE
    END;

play_card(tt, cc) =
    PRE
        // Checks if the game has started and hasn't finished
        started = TRUE & finished = FALSE
        // Ensures that the input is a playable card
        & tt : CARD_TYPE & cc : COLORS & (tt, cc) : PLAYABLE_CARDS
        // Checks if the card is on current player's deck
        & (curr_player = 0 =>
            (tt /: WILD => (tt, cc) : ran(deck_p1)) & (tt : WILD => (tt, BLACK) : ran(deck_p1)))
        & (curr_player = 1 =>
            (tt /: WILD => (tt, cc) : ran(deck_p2)) & (tt : WILD => (tt, BLACK) : ran(deck_p2)))
        // Checks if the card can be played
        & CAN_PLAY(tt, cc, FST(top_card), SND(top_card)) = TRUE
    THEN
        // Update top card
        top_card := tt |-> cc ||
        // Reset said uno
        said_uno := FALSE ||
        // Perform special cards actions
        IF tt = BLOCK
        THEN
            IF curr_player = 0
            THEN
                // Remove played card from player's deck
                ANY ii
                WHERE ii : (1..size(deck_p1)) & ((tt /: WILD & deck_p1(ii) = (tt, cc)) or (tt : WILD & deck_p1(ii) = (tt, BLACK)))
                THEN
                    // Add PENALTY cards to player's deck
                    IF size(deck_p1) = 2 & said_uno = FALSE
                    THEN
                        deck_p1 := deck /|\ PENALTY ||
                        // Add old top card to deck
                        IF FST(top_card) : WILD
                        THEN deck := (deck <- (FST(top_card), BLACK)) \|/ PENALTY
                        ELSE deck := (deck <- top_card) \|/ PENALTY
                        END
                    ELSE
                        deck_p1 := (deck_p1 /|\ (ii - 1)) ^ (deck_p1 \|/ ii) ||
                        // Add old top card to deck
                        IF FST(top_card) : WILD
                        THEN deck := (deck <- (FST(top_card), BLACK))
                        ELSE deck := deck <- top_card
                        END ||
                        // Verify if the game has finished
                        IF size(deck_p1) = 1 THEN finished := TRUE END
                    END
                END
            ELSE
                ANY ii
                WHERE ii : (1..size(deck_p2)) & ((tt /: WILD & deck_p2(ii) = (tt, cc)) or (tt : WILD & deck_p2(ii) = (tt, BLACK)))
                THEN
                    // Add PENALTY cards to player's deck
                    IF size(deck_p2) = 2 & said_uno = FALSE
                    THEN
                        deck_p2 := deck /|\ PENALTY ||
                        // Add old top card to deck
                        IF FST(top_card) : WILD
                        THEN deck := (deck <- (FST(top_card), BLACK)) \|/ PENALTY
                        ELSE deck := (deck <- top_card) \|/ PENALTY
                        END
                    ELSE
                        deck_p2 := (deck_p2 /|\ (ii - 1)) ^ (deck_p2 \|/ ii) ||
                        // Add old top card to deck
                        IF FST(top_card) : WILD
                        THEN deck := (deck <- (FST(top_card), BLACK))
                        ELSE deck := deck <- top_card
                        END ||
                        // Verify if the game has finished
                        IF size(deck_p2) = 1 THEN finished := TRUE END
                    END
                END
            END
        ELSIF tt = PLUS_TWO
        THEN
            IF curr_player = 0
            THEN
                ANY ii
                WHERE ii : (1..size(deck_p1)) & ((tt /: WILD & deck_p1(ii) = (tt, cc)) or (tt : WILD & deck_p1(ii) = (tt, BLACK)))
                THEN
                    // Add PENALTY cards to player's deck
                    IF size(deck_p1) = 2 & said_uno = FALSE
                    THEN
                        // "Push back" the old top card to deck and "pop front" 2 cards
                        IF FST(top_card) : WILD
                        THEN
                            deck := (deck <- (FST(top_card), BLACK)) \|/ (2 + PENALTY)
                        ELSE
                            deck := (deck <- top_card) \|/ (2 + PENALTY)
                        END ||
                        // Remove played card and add PENALTY cards
                        deck_p1 := (deck_p1 /|\ (ii - 1)) ^ (deck_p1 \|/ ii) ^ ((deck \|/ 2) /|\ PENALTY)
                    ELSE
                        // "Push back" the old top card to deck and "pop front" 2 cards
                        IF FST(top_card) : WILD
                        THEN
                            deck := (deck <- (FST(top_card), BLACK)) \|/ 2
                        ELSE
                            deck := (deck <- top_card) \|/ 2
                        END ||
                        // Verify if the game has finished
                        IF size(deck_p1) = 1 THEN finished := TRUE END ||
                        // Remove played card
                        deck_p1 := (deck_p1 /|\ (ii - 1)) ^ (deck_p1 \|/ ii)
                    END ||
                    // Add 2 cards from the front of the deck to the next player's deck
                    deck_p2 := deck_p2 ^ (deck /|\ 2)
                END
            ELSE
                ANY ii
                WHERE ii : (1..size(deck_p2)) & ((tt /: WILD & deck_p2(ii) = (tt, cc)) or (tt : WILD & deck_p2(ii) = (tt, BLACK)))
                THEN
                    // Add PENALTY cards to player's deck
                    IF size(deck_p2) = 2 & said_uno = FALSE
                    THEN
                        // "Push back" the old top card to deck and "pop front" 2 cards
                        IF FST(top_card) : WILD
                        THEN
                            deck := (deck <- (FST(top_card), BLACK)) \|/ (2 + PENALTY)
                        ELSE
                            deck := (deck <- top_card) \|/ (2 + PENALTY)
                        END ||
                        // Add 2 cards from the front of the deck to the next player's deck
                        deck_p2 := (deck_p2 /|\ (ii - 1)) ^ (deck_p2 \|/ ii) ^ ((deck \|/ 2) /|\ PENALTY)
                    ELSE
                        // "Push back" the old top card to deck and "pop front" 2 cards
                        IF FST(top_card) : WILD
                        THEN
                            deck := (deck <- (FST(top_card), BLACK)) \|/ 2
                        ELSE
                            deck := (deck <- top_card) \|/ 2
                        END ||
                        // Verify if the game has finished
                        IF size(deck_p2) = 1 THEN finished := TRUE END ||
                        // Remove played card
                        deck_p2 := (deck_p2 /|\ (ii - 1)) ^ (deck_p2 \|/ ii)
                    END ||
                    // Add 2 cards from the front of the deck to the next player's deck
                    deck_p1 := deck_p1 ^ (deck /|\ 2)
                END
            END
        ELSIF tt = PLUS_FOUR
        THEN
            IF curr_player = 0
            THEN
                ANY ii
                WHERE ii : (1..size(deck_p1)) & ((tt /: WILD & deck_p1(ii) = (tt, cc)) or (tt : WILD & deck_p1(ii) = (tt, BLACK)))
                THEN
                    // Add PENALTY cards to player's deck
                    IF size(deck_p1) = 2 & said_uno = FALSE
                    THEN
                        // "Push back" the old top card to deck and "pop front" 4 cards
                        IF FST(top_card) : WILD
                        THEN
                            deck := (deck <- (FST(top_card), BLACK)) \|/ (4 + PENALTY)
                        ELSE
                            deck := (deck <- top_card) \|/ (4 + PENALTY)
                        END ||
                        // Remove played card and add PENALTY cards
                        deck_p1 := (deck_p1 /|\ (ii - 1)) ^ (deck_p1 \|/ ii) ^ ((deck \|/ 4) /|\ PENALTY)
                    ELSE
                        // "Push back" the old top card to deck and "pop front" 4 cards
                        IF FST(top_card) : WILD
                        THEN
                            deck := (deck <- (FST(top_card), BLACK)) \|/ 4
                        ELSE
                            deck := (deck <- top_card) \|/ 4
                        END ||
                        // Verify if the game has finished
                        IF size(deck_p1) = 1 THEN finished := TRUE END ||
                        // Remove played card
                        deck_p1 := (deck_p1 /|\ (ii - 1)) ^ (deck_p1 \|/ ii)
                    END ||
                    // Add 4 cards from the front of the deck to the next player's deck
                    deck_p2 := deck_p2 ^ (deck /|\ 4)
                END
            ELSE
                ANY ii
                WHERE ii : (1..size(deck_p2)) & ((tt /: WILD & deck_p2(ii) = (tt, cc)) or (tt : WILD & deck_p2(ii) = (tt, BLACK)))
                THEN
                    // Add PENALTY cards to player's deck
                    IF size(deck_p2) = 2 & said_uno = FALSE
                    THEN
                        // "Push back" the old top card to deck and "pop front" 4 cards
                        IF FST(top_card) : WILD
                        THEN
                            deck := (deck <- (FST(top_card), BLACK)) \|/ (4 + PENALTY)
                        ELSE
                            deck := (deck <- top_card) \|/ (4 + PENALTY)
                        END ||
                        // Remove played card and add PENALTY cards
                        deck_p2 := (deck_p2 /|\ (ii - 1)) ^ (deck_p2 \|/ ii) ^ ((deck \|/ 4) /|\ PENALTY)
                    ELSE
                        // "Push back" the old top card to deck and "pop front" 4 cards
                        IF FST(top_card) : WILD
                        THEN
                            deck := (deck <- (FST(top_card), BLACK)) \|/ 4
                        ELSE
                            deck := (deck <- top_card) \|/ 4
                        END ||
                        // Verify if the game has finished
                        IF size(deck_p2) = 1 THEN finished := TRUE END ||
                        // Remove played card
                        deck_p2 := (deck_p2 /|\ (ii - 1)) ^ (deck_p2 \|/ ii)
                    END ||
                    // Add 4 cards from the front of the deck to the next player's deck
                    deck_p1 := deck_p1 ^ (deck /|\ 4)
                END
            END
        ELSE
            IF curr_player = 0
            THEN
                // Verify if the game has finished
                IF size(deck_p1) = 1
                THEN finished := TRUE
                ELSE curr_player := (curr_player + 1) mod N_PLAYERS // Go to next player
                END ||
                // Remove played card from player's deck
                ANY ii
                WHERE ii : (1..size(deck_p1)) & ((tt /: WILD & deck_p1(ii) = (tt, cc)) or (tt : WILD & deck_p1(ii) = (tt, BLACK)))
                THEN
                    // Add PENALTY cards to player's deck
                    IF (size(deck_p1) = 2 & said_uno = FALSE)
                    THEN
                        // Add old top card to deck
                        IF FST(top_card) : WILD
                        THEN deck := (deck <- (FST(top_card), BLACK)) \|/ PENALTY
                        ELSE deck := (deck <- top_card) \|/ PENALTY
                        END ||
                        // Remove played card and add PENALTY cards
                        deck_p1 := (deck_p1 /|\ (ii - 1)) ^ (deck_p1 \|/ ii) ^ (deck /|\ PENALTY)
                    ELSE
                        // Add old top card to deck
                        IF FST(top_card) : WILD
                        THEN deck := deck <- (FST(top_card), BLACK)
                        ELSE deck := deck <- top_card
                        END ||
                        // Remove played card
                        deck_p1 := (deck_p1 /|\ (ii - 1)) ^ (deck_p1 \|/ ii)
                    END
                END
            ELSE
                // Verify if the game has finished
                IF size(deck_p2) = 1
                THEN finished := TRUE
                ELSE curr_player := (curr_player + 1) mod N_PLAYERS // Go to next player
                END ||
                // Remove played card from player's deck
                ANY ii
                WHERE ii : (1..size(deck_p2)) & ((tt /: WILD & deck_p2(ii) = (tt, cc)) or (tt : WILD & deck_p2(ii) = (tt, BLACK)))
                THEN
                    // Add PENALTY cards to player's deck
                    IF size(deck_p2) = 2 & said_uno = FALSE
                    THEN
                        // Add old top card to deck
                        IF FST(top_card) : WILD
                        THEN deck := (deck <- (FST(top_card), BLACK)) \|/ PENALTY
                        ELSE deck := (deck <- top_card) \|/ PENALTY
                        END ||
                        // Remove played card and add PENALTY cards
                        deck_p2 := (deck_p2 /|\ (ii - 1)) ^ (deck_p2 \|/ ii) ^ (deck /|\ PENALTY)
                    ELSE
                        // Add old top card to deck
                        IF FST(top_card) : WILD
                        THEN deck := deck <- (FST(top_card), BLACK)
                        ELSE deck := deck <- top_card
                        END ||
                        // Remove played card
                        deck_p2 := (deck_p2 /|\ (ii - 1)) ^ (deck_p2 \|/ ii)
                    END
                END
            END
        END
    END;

start_game =
    PRE started = FALSE or finished = TRUE
    THEN
        ANY deal
        WHERE deal : perm(CARDS-{top_card})
        THEN
            deck_p1, deck_p2 := deal /|\ INI_CARDS, (deal \|/ INI_CARDS) /|\ INI_CARDS ||
            deck := deal \|/ (N_PLAYERS*INI_CARDS) ||
            started, finished := TRUE, FALSE
        END
    END;

ww <-- get_winner =
    PRE
        started = TRUE & finished = TRUE
        & (size(deck_p1) = 0 or size(deck_p2) = 0)
    THEN
        IF size(deck_p1) = 0
        THEN ww := 0
        ELSE ww := 1
        END
    END

END
