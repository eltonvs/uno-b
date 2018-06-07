MACHINE Cards

SETS
    CARD_TYPE = {ZERO, ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, PLUS_TWO, BLOCK, SWITCH, PLUS_FOUR, JOKER};
    COLORS = {RED, GREEN, BLUE, YELLOW, BLACK}

ABSTRACT_CONSTANTS wild, cards, playable_cards

PROPERTIES
    // Define wild cards
    wild = {PLUS_FOUR, JOKER}
    // Define cards as a relation between CARD TYPE and COLORS
    & cards : CARD_TYPE<->COLORS
    // The black cards must be wild cards
    & dom(cards |> {BLACK}) = wild
    // The wild cards must be black
    & ran(wild <| cards) = {BLACK}
    // The non black cards must not be wild
    & dom(cards |>> {BLACK}) = CARD_TYPE - wild
    // The non wild cards must not be black
    & ran(wild <<| cards) = COLORS - {BLACK}
    // All non-wild cards must appear on cards in all colors
    & !(tt) . (tt : CARD_TYPE - wild =>
        !(cc) . (cc : COLORS-{BLACK} => (tt, cc) : cards))
    // Defines playable cards as all combinations of non-black cards
    & playable_cards = CARD_TYPE*(COLORS-{BLACK})

END
