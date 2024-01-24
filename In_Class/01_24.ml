let cylinder_volume r h = let pi = 3.14159265389793 in r *. r *. pi *. h

let power (e: int) (term: float) : float =
  if (e == 0) then 1
  else if (e == 1) then term
  else term *. power (e - 1) term
