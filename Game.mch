MACHINE Game

CONSTANTS MAX_PLAYERS

PROPERTIES MAX_PLAYERS = 2

VARIABLES n_players, curr_player, started

INVARIANT
    n_players : NAT
    & n_players : (2..MAX_PLAYERS)
    & curr_player : (0..(n_players-1))
    & started : BOOL

INITIALISATION n_players := 2 || curr_player := 0 || started := FALSE

OPERATIONS

setup_players(nn) =
    PRE nn : (2..MAX_PLAYERS) & started = FALSE
    THEN n_players := nn
    END;

next_player(nn) =
    PRE nn : {-2, -1, 1, 2}
    THEN curr_player := (curr_player + n_players + nn) mod n_players
    END;

np <-- get_next_player(nn) =
    PRE nn : {-1, 1}
    THEN np := (curr_player + n_players + nn) mod n_players
    END;

set_started(ss) =
    PRE ss : BOOL
    THEN started := ss
    END

END
