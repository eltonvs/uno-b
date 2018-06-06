MACHINE Uno

EXTENDS Game

SEES Random, Cards

ABSTRACT_CONSTANTS FST, SND

PROPERTIES
    FST = %(tt, cc) . (tt : CARD_TYPE & cc : COLORS | tt)
    & SND = %(tt, cc) . (tt : CARD_TYPE & cc : COLORS | cc)

VARIABLES top_card, deck

INVARIANT top_card : cards & deck : seq(cards)

INITIALISATION top_card :: (cards |>> {BLACK}) || deck :: perm(cards)

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
PRE started = TRUE & tt : CARD_TYPE & cc : COLORS & (FST(top_card) = tt or SND(top_card) = cc)
THEN top_card :=  (tt, cc)
END;

start_game = set_started(TRUE)

END