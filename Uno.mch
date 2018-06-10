MACHINE Uno

EXTENDS Game

SEES Cards

ABSTRACT_CONSTANTS FST, SND

PROPERTIES
    FST = %(tt, cc) . (tt : CARD_TYPE & cc : COLORS | tt)
    & SND = %(tt, cc) . (tt : CARD_TYPE & cc : COLORS | cc)

VARIABLES
    top_card, deck, deck_p1, deck_p2, said_uno

INVARIANT
    top_card : PLAYABLE_CARDS
    & SND(top_card) /= BLACK
    & deck : seq(CARDS)
    & deck_p1 : seq(CARDS)
    & deck_p2 : seq(CARDS)
    & said_uno : BOOL

INITIALISATION
    top_card :: (CARDS |>> {BLACK}) || deck :: perm(CARDS) || deck_p1 := <> || deck_p2 := <> || said_uno := FALSE

OPERATIONS

cc <-- get_top_card_type = cc := FST(top_card);
cc <-- get_top_card_color = cc := SND(top_card);

tt, cc <-- draw_card =
    PRE
        started = TRUE
        & (curr_player = 0 =>
            !(pt, pc) . (pt : CARD_TYPE & pc : COLORS & (pt, pc) : ran(deck_p1) =>
                pt /: WILD & pc /= BLACK & FST(top_card) /= pt & SND(top_card) /= pc))
        & (curr_player = 1 =>
            !(pt, pc) . (pt : CARD_TYPE & pc : COLORS & (pt, pc) : ran(deck_p2) =>
                pt /: WILD & pc /= BLACK & FST(top_card) /= pt & SND(top_card) /= pc))
    THEN
        ANY ii WHERE ii : (1..size(deck))
        THEN
            tt, cc := FST(deck(ii)), SND(deck(ii)) ||
            deck := (deck /|\ (ii - 1)) ^ (deck \|/ ii) ||
            IF curr_player = 0
            THEN deck_p1 := deck_p1 <- deck(ii)
            ELSE deck_p2 := deck_p2 <- deck(ii)
            END ||
            // If the picked up card cannot be played, go to next player
            IF FST(deck(ii)) /: WILD & FST(deck(ii)) /= FST(top_card) & SND(deck(ii)) /= SND(top_card)
            THEN next_player
            END
    	END
    END;

say_uno =
    PRE
        // The game must be started
        started = TRUE
        // User didn't said uno yet
        & said_uno = FALSE
        // User has only one card and it's a playable card
        & (curr_player = 0 =>
            !(pt, pc) . (pt : CARD_TYPE & pc : COLORS & (pt, pc) : ran(deck_p1) =>
                pt : WILD or pc = BLACK or FST(top_card) = pt or SND(top_card) = pc)
            & size(deck_p1) = 1)
        & (curr_player = 1 =>
            !(pt, pc) . (pt : CARD_TYPE & pc : COLORS & (pt, pc) : ran(deck_p2) =>
                pt : WILD or pc = BLACK or FST(top_card) = pt or SND(top_card) = pc)
            & size(deck_p2) = 1)
    THEN
        said_uno := TRUE
    END;

play_card(tt, cc) =
    PRE
        // Checks if the game has started
        started = TRUE
        // Ensures that the input is a playable card
        & tt : CARD_TYPE & cc : COLORS & (tt, cc) : PLAYABLE_CARDS
        // Checks if the card is on current player's deck
        & (curr_player = 0 =>
            (tt /: WILD => (tt, cc) : ran(deck_p1)) & (tt : WILD => (tt, BLACK) : ran(deck_p1)))
        & (curr_player = 1 =>
            (tt /: WILD => (tt, cc) : ran(deck_p2)) & (tt : WILD => (tt, BLACK) : ran(deck_p2)))
        // Checks if the card matches with the top card
        & (tt : WILD or FST(top_card) = tt or SND(top_card) = cc)
    THEN
        // Update top card
        top_card := tt |-> cc ||
        // Reset said uno
        said_uno := FALSE ||
        // Perform special cards actions
        IF tt : {BLOCK, PLUS_TWO, PLUS_FOUR}
        THEN
            // Do not call next_player == skip him
            IF tt = BLOCK
            THEN
                // Add old top card to deck
                IF FST(top_card) : WILD
                THEN deck := (deck <- (FST(top_card), BLACK))
                ELSE deck := deck <- top_card
                END ||
                IF curr_player = 0
                THEN
                    // Remove played card from player's deck
                    ANY ii
                    WHERE ii : (1..size(deck_p1)) & ((tt /: WILD & deck_p1(ii) = (tt, cc)) or (tt : WILD & deck_p1(ii) = (tt, BLACK)))
                    THEN deck_p1 := (deck_p1 /|\ (ii - 1)) ^ (deck_p1 \|/ ii)
                    END
                ELSE
                    ANY ii
                    WHERE ii : (1..size(deck_p2)) & ((tt /: WILD & deck_p2(ii) = (tt, cc)) or (tt : WILD & deck_p2(ii) = (tt, BLACK)))
                    THEN deck_p2 := (deck_p2 /|\ (ii - 1)) ^ (deck_p2 \|/ ii)
                    END
                END
            ELSIF tt = PLUS_TWO
            THEN
                IF curr_player = 0
                THEN
                    ANY ii
                    WHERE ii : (1..size(deck_p1)) & ((tt /: WILD & deck_p1(ii) = (tt, cc)) or (tt : WILD & deck_p1(ii) = (tt, BLACK)))
                    THEN
                        // "Push back" the old top card to deck and "pop front" 2 cards
                        IF FST(top_card) : WILD
                        THEN
                            deck := (deck <- (FST(top_card), BLACK)) \|/ 2
                        ELSE
                            deck := (deck <- top_card) \|/ 2
                        END ||
                        // Add 2 cards from the front of the deck to the next player's deck
                        deck_p2 := deck_p2 ^ (deck /|\ 2)
                    END
                ELSE
                    ANY ii
                    WHERE ii : (1..size(deck_p2)) & ((tt /: WILD & deck_p2(ii) = (tt, cc)) or (tt : WILD & deck_p2(ii) = (tt, BLACK)))
                    THEN
                        // "Push back" the old top card to deck and "pop front" 2 cards
                        IF FST(top_card) : WILD
                        THEN
                            deck := (deck <- (FST(top_card), BLACK)) \|/ 2
                        ELSE
                            deck := (deck <- top_card) \|/ 2
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
                        // "Push back" the old top card to deck and "pop front" 4 cards
                        IF FST(top_card) : WILD
                        THEN
                            deck := (deck <- (FST(top_card), BLACK)) \|/ 4
                        ELSE
                            deck := (deck <- top_card) \|/ 4
                        END ||
                        // Add 4 cards from the front of the deck to the next player's deck
                        deck_p2 := deck_p2 ^ (deck /|\ 4)
                    END
                ELSE
                    ANY ii
                    WHERE ii : (1..size(deck_p2)) & ((tt /: WILD & deck_p2(ii) = (tt, cc)) or (tt : WILD & deck_p2(ii) = (tt, BLACK)))
                    THEN
                        // "Push back" the old top card to deck and "pop front" 4 cards
                        IF FST(top_card) : WILD
                        THEN
                            deck := (deck <- (FST(top_card), BLACK)) \|/ 4
                        ELSE
                            deck := (deck <- top_card) \|/ 4
                        END ||
                        // Add 4 cards from the front of the deck to the next player's deck
                        deck_p1 := deck_p1 ^ (deck /|\ 4)
                    END
                END
            END
        ELSE
            // Add old top card to deck
            IF FST(top_card) : WILD
            THEN deck := deck <- (FST(top_card), BLACK)
            ELSE deck := deck <- top_card
            END ||
            // Remove played card from player's deck
            IF curr_player = 0
            THEN
                ANY ii
                WHERE ii : (1..size(deck_p1)) & ((tt /: WILD & deck_p1(ii) = (tt, cc)) or (tt : WILD & deck_p1(ii) = (tt, BLACK)))
                THEN
                    deck_p1 := (deck_p1 /|\ (ii - 1)) ^ (deck_p1 \|/ ii)
                END
            ELSE
                ANY ii
                WHERE ii : (1..size(deck_p2)) & ((tt /: WILD & deck_p2(ii) = (tt, cc)) or (tt : WILD & deck_p2(ii) = (tt, BLACK)))
                THEN
                    deck_p2 := (deck_p2 /|\ (ii - 1)) ^ (deck_p2 \|/ ii)
                END
            END ||
            // Go to next player
            next_player
        END
    END;

start_game =
    PRE started = FALSE
    THEN
        ANY deal
        WHERE deal : perm(CARDS-{top_card})
        THEN
            deck_p1, deck_p2 := deal /|\ INI_CARDS, (deal \|/ INI_CARDS) /|\ INI_CARDS ||
            deck := deal \|/ (N_PLAYERS*INI_CARDS) ||
            set_started(TRUE)
        END
    END

END
