MACHINE Uno

EXTENDS Game

SEES Random, Cards

ABSTRACT_CONSTANTS FST, SND

PROPERTIES
    FST = %(tt, cc) . (tt : CARD_TYPE & cc : COLORS | tt)
    & SND = %(tt, cc) . (tt : CARD_TYPE & cc : COLORS | cc)

VARIABLES top_card, deck, switch_factor

INVARIANT
    top_card : playable_cards
    & SND(top_card) /= BLACK
    & deck : seq(cards)
    & switch_factor : {-1, 1}

INITIALISATION top_card :: (cards |>> {BLACK}) || deck :: perm(cards) || switch_factor := 1

OPERATIONS

cc <-- get_top_card_type = cc := FST(top_card);
cc <-- get_top_card_color = cc := SND(top_card);

tt, cc <-- draw_card =
    PRE started = TRUE
    THEN ANY vv WHERE vv : ran(deck) THEN
    	tt, cc := FST(vv), SND(vv)
    	END
    END;

play_card(tt, cc) =
    PRE started = TRUE & tt : CARD_TYPE & cc : COLORS & (tt, cc) : playable_cards & (FST(top_card) = tt or SND(top_card) = cc)
    THEN
        top_card :=  (tt, cc) ||
        IF tt : {PLUS_FOUR, BLOCK}
        THEN next_player(2 * switch_factor)
        ELSE
            IF tt = SWITCH
            THEN switch_factor := switch_factor*(-1) || next_player((-1)*switch_factor)
            ELSE next_player(switch_factor)
            END
        END
    END;

start_game = set_started(TRUE)

END
