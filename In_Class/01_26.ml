(*
sumTo 3
if 3 = 0 then 0 else 3 + sumTo (3 - 1)
if false then 0 else 3 + sumTo (3 - 1)
3 + sumTo (3 - 1)
3 + sumTo (2)
3 + (if 2 = 0 then 0 else 2 + sumTo (2 - 1))
3 + (if false then 0 else 2 + sumTo (2 - 1))
3 + (2 + sumTo (2 - 1))
3 + (2 + sumTo (1))
3 + (2 + (if 1 = 0 then 0 else 1 + sumTo (1 - 1)))
3 + (2 + (if false then 0 else 1 + sumTo (1 - 1)))
3 + (2 + (1 + sumTo (1 - 1)))
3 + (2 + (1 + sumTo (0))))
3 + (2 + (1 + (if 0 = 0 then 0 else 0 + sumTo (0 - 1))))
3 + (2 + (1 + (if true then 0 else 0 + sumTo (0 - 1))))
3 + (2 + (1 + (0)))
3 + (2 + (1))
3 + (3)
6
*)

let cube x = power 3 x
