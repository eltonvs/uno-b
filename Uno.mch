MACHINE Uno

EXTENDS Game

SEES Cards

ABSTRACT_CONSTANTS FST, SND

PROPERTIES
    FST = %(tt, cc) . (tt : CARD_TYPE & cc : COLORS | tt)
    & SND = %(tt, cc) . (tt : CARD_TYPE & cc : COLORS | cc)

VARIABLES
    top_card, switch_factor, deck, deck_p1, deck_p2

INVARIANT
    top_card : playable_cards
    & SND(top_card) /= BLACK
    & switch_factor : {-1, 1}
    & deck : seq(cards)
    & deck_p1 : seq(cards)
    & deck_p2 : seq(cards)

INITIALISATION
    top_card :: (cards |>> {BLACK}) || switch_factor := 1 || deck :: perm(cards) || deck_p1 := <> || deck_p2 := <>

OPERATIONS

cc <-- get_top_card_type = cc := FST(top_card);
cc <-- get_top_card_color = cc := SND(top_card);

tt, cc <-- draw_card =
    PRE
        started = TRUE
        & (curr_player = 0 =>
            !(pt, pc) . (pt : CARD_TYPE & pc : COLORS & (pt, pc) : ran(deck_p1) =>
                pt /: wild & pc /= BLACK & FST(top_card) /= pt & SND(top_card) /= pc))
        & (curr_player = 1 =>
            !(pt, pc) . (pt : CARD_TYPE & pc : COLORS & (pt, pc) : ran(deck_p2) =>
                pt /: wild & pc /= BLACK & FST(top_card) /= pt & SND(top_card) /= pc))
    THEN
        ANY ii WHERE ii : (1..size(deck))
        THEN
            tt, cc := FST(deck(ii)), SND(deck(ii)) ||
            deck := (deck /|\ (ii - 1)) ^ (deck \|/ ii) ||
            IF curr_player = 0
            THEN deck_p1 := deck_p1 <- deck(ii)
            ELSE deck_p2 := deck_p2 <- deck(ii)
            END
    	END
    END;

play_card(tt, cc) =
    PRE
        // Checks if the game has started
        started = TRUE
        // Ensures that the input is a playable card
        & tt : CARD_TYPE & cc : COLORS & (tt, cc) : playable_cards
        // Checks if the card is on current player's deck
        & (curr_player = 0 =>
            (tt /: wild => (tt, cc) : ran(deck_p1)) & (tt : wild => (tt, BLACK) : ran(deck_p1)))
        & (curr_player = 1 =>
            (tt /: wild => (tt, cc) : ran(deck_p2)) & (tt : wild => (tt, BLACK) : ran(deck_p2)))
        // Checks if the card matches with the top card
        & (tt : wild or FST(top_card) = tt or SND(top_card) = cc)
    THEN
        // Update top card
        top_card := (tt, cc) ||
        // Add old top card to deck
        IF FST(top_card) : wild
        THEN deck := deck <- (FST(top_card), BLACK)
        ELSE deck := deck <- top_card
        END ||
        // Remove played card from player's deck
        IF curr_player = 0
        THEN
            ANY ii
            WHERE ii : (1..size(deck_p1)) & (deck_p1(ii) = (tt, cc) or deck_p1(ii) = (tt, BLACK))
            THEN deck_p1 := (deck_p1 /|\ (ii - 1)) ^ (deck_p1 \|/ ii)
            END
        ELSE
            ANY ii
            WHERE ii : (1..size(deck_p2)) & (deck_p2(ii) = (tt, cc) or deck_p2(ii) = (tt, BLACK))
            THEN deck_p2 := (deck_p2 /|\ (ii - 1)) ^ (deck_p2 \|/ ii)
            END
        END ||
        // Perform special cards actions
        IF tt : {PLUS_FOUR, BLOCK}
        THEN next_player(2 * switch_factor)
        ELSE
            IF tt = SWITCH
            THEN switch_factor := switch_factor*(-1) || next_player((-1)*switch_factor)
            ELSE next_player(switch_factor)
            END
        END
    END;

start_game =
    PRE started = FALSE
    THEN
        // Temporary workaround
        ANY d1, d2
        WHERE d1 : iseq(cards) & size(d1) = 7 & d2 : iseq(cards) & size(d2) = 7
        THEN deck_p1, deck_p2 := d1, d2 || set_started(TRUE)
        END
    END

END
