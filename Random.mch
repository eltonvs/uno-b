MACHINE Random

OPERATIONS

nn <-- get_number(lb, ub) =
    PRE lb : NAT & ub : NAT & lb < ub
    THEN nn :: (lb..ub)
    END

END
