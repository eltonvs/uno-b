MACHINE Game

CONSTANTS N_PLAYERS, INI_CARDS

PROPERTIES
    N_PLAYERS = 2
    & INI_CARDS = 7

VARIABLES curr_player, started, finished

INVARIANT
    curr_player : (0..N_PLAYERS-1)
    & started : BOOL
    & finished : BOOL
    & (finished = TRUE => started = TRUE)

INITIALISATION curr_player := 0 || started := FALSE || finished := FALSE

OPERATIONS

next_player =
    PRE started = TRUE & finished = FALSE
    THEN curr_player := (curr_player + 1) mod N_PLAYERS
    END;

start =
    PRE started = FALSE or finished = TRUE
    THEN started, finished := TRUE, FALSE
    END;

finish =
    PRE started = TRUE & finished = FALSE
    THEN finished := TRUE
    END

END
