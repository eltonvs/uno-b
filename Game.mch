MACHINE Game

VARIABLES n_players, curr_player, started

INVARIANT
    n_players : NAT
    & n_players : (2..10)
    & curr_player : (0..(n_players-1))
    & started : BOOL

INITIALISATION n_players := 2 || curr_player := 0 || started := FALSE

OPERATIONS

setup_players(nn) =
    PRE nn : (2..10) & started = FALSE
    THEN n_players := nn
    END;

next_player = curr_player := (curr_player + 1) mod n_players;

set_started(ss) =
    PRE ss : BOOL
    THEN started := ss
    END

END
