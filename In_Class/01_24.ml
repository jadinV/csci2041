let cylinder_volume r h = let pi = 3.14159265389793 in r *. r *. pi *. h

let power (e : int) (term : float) = if (e == 0) : 1 else if (e == 1) : term else : power term (e - 1) *. term
