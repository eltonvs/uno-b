MACHINE Cards

SETS
    CARD_TYPE = {ZERO, ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, PLUS_TWO, BLOCK, SWITCH, PLUS_FOUR, JOKER};
    COLORS = {RED, GREEN, BLUE, YELLOW, BLACK}

ABSTRACT_CONSTANTS wild, cards, playable_cards

PROPERTIES
    wild = {PLUS_FOUR, JOKER}		// Define wild cards
    & cards : CARD_TYPE<->COLORS		// Define cards as a relation between CARD TYPE and COLORS
    & dom(cards |> {BLACK}) = wild	// The black cards must be wild cards
    & ran(wild <| cards) = {BLACK}	// The wild cards must be black
    & dom(cards |>> {BLACK}) = CARD_TYPE - wild
    & ran(wild <<| cards) = COLORS - {BLACK}
    & playable_cards = (cards |>> {BLACK}) \/ wild*(COLORS-{BLACK})

END
