MACHINE Uno_ctx

SEES Cards

CONCRETE_CONSTANTS PENALTY, N_PLAYERS, INI_CARDS, NUM_CARDS, INITIAL_DECK_T, INITIAL_DECK_C

PROPERTIES
    PENALTY = 2
    & N_PLAYERS = 2
    & INI_CARDS = 7
    & NUM_CARDS = 54
    & INITIAL_DECK_T : (0..(NUM_CARDS - 1)) --> CARD_TYPE
    & INITIAL_DECK_C : (0..(NUM_CARDS - 1)) --> COLORS
    & INITIAL_DECK_T = {
        0 |-> ZERO, 1 |-> ZERO, 2 |-> ZERO, 3 |-> ZERO, 4 |-> ONE,
        5 |-> ONE, 6 |-> ONE, 7 |-> ONE, 8 |-> TWO, 9 |-> TWO,
        10 |-> TWO, 11 |-> TWO, 12 |-> THREE, 13 |-> THREE, 14 |-> THREE,
        15 |-> THREE, 16 |-> FOUR, 17 |-> FOUR, 18 |-> FOUR, 19 |-> FOUR,
        20 |-> FIVE, 21 |-> FIVE, 22 |-> FIVE, 23 |-> FIVE, 24 |-> SIX,
        25 |-> SIX, 26 |-> SIX, 27 |-> SIX, 28 |-> SEVEN, 29 |-> SEVEN,
        30 |-> SEVEN, 31 |-> SEVEN, 32 |-> EIGHT, 33 |-> EIGHT, 34 |-> EIGHT,
        35 |-> EIGHT, 36 |-> NINE, 37 |-> NINE, 38 |-> NINE, 39 |-> NINE,
        40 |-> PLUS_TWO, 41 |-> PLUS_TWO, 42 |-> PLUS_TWO, 43 |-> PLUS_TWO, 44 |-> BLOCK,
        45 |-> BLOCK, 46 |-> BLOCK, 47 |-> BLOCK, 48 |-> SWITCH, 49 |-> SWITCH,
        50 |-> SWITCH, 51 |-> SWITCH, 52 |-> PLUS_FOUR, 53 |-> JOKER
    }
    & INITIAL_DECK_C = {
        0 |-> RED, 1 |-> GREEN, 2 |-> BLUE, 3 |-> YELLOW, 4 |-> RED,
        5 |->  GREEN, 6 |-> BLUE, 7 |-> YELLOW, 8 |-> RED, 9 |-> GREEN,
        10 |-> BLUE, 11 |-> YELLOW, 12 |-> RED, 13 |-> GREEN, 14 |-> BLUE,
        15 |-> YELLOW, 16 |-> RED, 17 |-> GREEN, 18 |-> BLUE, 19 |-> YELLOW,
        20 |-> RED, 21 |-> GREEN, 22 |-> BLUE, 23 |-> YELLOW, 24 |-> RED,
        25 |-> GREEN, 26 |-> BLUE, 27 |-> YELLOW, 28 |-> RED, 29 |-> GREEN,
        30 |-> BLUE, 31 |-> YELLOW, 32 |-> RED, 33 |-> GREEN, 34 |-> BLUE,
        35 |-> YELLOW, 36 |-> RED, 37 |-> GREEN, 38 |-> BLUE, 39 |-> YELLOW,
        40 |-> RED, 41 |-> GREEN, 42 |-> BLUE, 43 |-> YELLOW, 44 |-> RED,
        45 |-> GREEN, 46 |-> BLUE, 47 |-> YELLOW, 48 |-> RED, 49 |-> GREEN,
        50 |-> BLUE, 51 |-> YELLOW, 52 |-> BLACK, 53 |-> BLACK
    }

END
