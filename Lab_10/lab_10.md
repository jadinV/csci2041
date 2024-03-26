# Lab 10: Reasoning about correctness
by Jadin Vetruba (vetru005)

1)
    1. Prove P(0) and P(1...n) -> P(n+1)
    2. prod([] @ l2) = prod [] * prod l2

    3. Base case: prod([] @ l2) = prod [] * prod l2

    prod([] @ l2) = prod [] * prod l2
    prod([] @ l2) = 1 * prod l2       by def of prod
    prod(l2) = 1 * prod l2            by property of @
    prod(l2) = prod l2                by arithmatic

    4. prod(x::xs @ l2) = prod (x::xs) * prod l2
    5. prod(l1 @ l2) = prod l1 * prod l2

    6. Inductive Case: prod(x::xs @ l2) = prod (x::xs) * prod l2

    prod(x::xs @ l2) = prod (x::xs) * prod l2
    prod(x::xs @ l2) = x * prod xs * prod l2      by def of prod
    x * prod (xs @ l2) = x * prod xs * prod l2    by def of prod
    x * prod xs * prod l2 = x * prod xs * prod l2 by inductive hypothesis

2)
    1. Prove P(0) and P(1...n) -> P(n+1)
    2. maximum ([] @ l2) = maxnat (maximum l1) (maximum l2)
    
    3. Base case: maximum ([] @ l2) = maxnat (maximum []) (maximum l2)

    maximum ([] @ l2) = maxnat (maximum []) (maximum l2)
    maximum ([] @ l2) = maxnat Zero (maximum l2)         by def of maximum
    maximum (l2) = maxnat Zero (maximum l2)              by property of @
    maximum l2 = maximum l2                              by property of maxnat
    
    4. maximum (x::xs @ l2) = maxnat (maximum x::xs) (maximum l2)
    5. maximum (l1 @ l2) = maxnat (maximum l1) (maximum l2)

    6. Inductive Case: maximum (x::xs @ l2) = maxnat (maximum x::xs) (maximum l2)

    maximum (x::xs @ l2) = maxnat (maximum x::xs) (maximum l2)
    maximum (x::xs @ l2) = maxnat (maxnat x (maximum xs)) (maximum l2)                         by def of maximum
    maximum (x::xs @ l2) = maxnat x (maxnat (maximum xs) (maximum l2))                         by property of maxnat
    maximum (x::(xs @ l2)) = maxnat x (maxnat (maximum xs) (maximum l2))                       by property of lists
    maxnat x (maximum xs @ l2) = maxnat x (maxnat (maximum xs) (maximum l2))                   by def of maximum
    maxnat x (maxnat (maximum xs) (maximum l2)) = maxnat x (maxnat (maximum xs) (maximum l2))  by inductive hypothesis