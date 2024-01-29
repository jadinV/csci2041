let lcm (x: int) (y: int) : int =
  let max = if x > y then x else y
  in let rec increment (d: int) : int =
    if x mod d = 0 && y mod d = 0 then d
    else increment (d + 1)
  in increment max

