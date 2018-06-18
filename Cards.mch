MACHINE Cards

SETS
    CARD_TYPE = {ZERO, ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, PLUS_TWO, BLOCK, SWITCH, PLUS_FOUR, JOKER};
    COLORS = {RED, GREEN, BLUE, YELLOW, BLACK}

ABSTRACT_CONSTANTS WILD, CARDS, PLAYABLE_CARDS

PROPERTIES
    // Define wild cards
    WILD <: CARD_TYPE
    & WILD = {PLUS_FOUR, JOKER}
    // Define cards as a relation between CARD TYPE and COLORS
    & CARDS <: CARD_TYPE*COLORS
    // The black cards must be wild cards
    & dom(CARDS |> {BLACK}) = WILD
    // The wild cards must be black
    & ran(WILD <| CARDS) = {BLACK}
    // The non black cards must not be wild
    & dom(CARDS |>> {BLACK}) = CARD_TYPE - WILD
    // The non wild cards must not be black
    & ran(WILD <<| CARDS) = COLORS - {BLACK}
    // All non-wild cards must appear on cards in all colors
    & !(tt) . (tt : CARD_TYPE - WILD =>
        !(cc) . (cc : COLORS-{BLACK} => (tt, cc) : CARDS))
    // Defines playable cards as all combinations of non-black cards
    & PLAYABLE_CARDS <: CARDS
    & PLAYABLE_CARDS = CARD_TYPE*(COLORS-{BLACK})

END
