MACHINE Game

CONSTANTS N_PLAYERS, INI_CARDS

PROPERTIES
    N_PLAYERS = 2
    & INI_CARDS = 7

VARIABLES curr_player, started

INVARIANT
    curr_player : (0..N_PLAYERS-1)
    & started : BOOL

INITIALISATION curr_player := 0 || started := FALSE

OPERATIONS

next_player = curr_player := (curr_player + 1) mod N_PLAYERS;

set_started(ss) =
    PRE ss : BOOL
    THEN started := ss
    END

END
