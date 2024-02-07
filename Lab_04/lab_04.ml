type fraction = int * int

let mul ((n1,d1): fraction) ((n2,d2): fraction) : fraction =
  (n1 * n2, d1 * d2)

let sub ((n1,d1): fraction) ((n2,d2): fraction) : fraction =
  (n1 * d2 - n2 * d1, d1 * d2)

let div ((n1,d1): fraction) ((n2,d2): fraction) : fraction =
  (n1 * d2, d1 * n2)

let rec simplify ((n1,d1): fraction) : fraction =
  match (n1, d1) with
  | (n, d) when n = 1 -> (n, d)
  | (n, d) when d = 1 -> (n, d)
  | (n, d) when n mod d = 0 -> (n / d, 1)
  | (n, d) when d mod n = 0 -> simplify (1, d / n)
  | (n, d) when d mod n = 2 -> simplify (n / 2, d / 2)
  | (n, d) -> (n, d)

let rec compute_lengths (words: string list) : (string * int) list =
  match words with
  | [] -> []
  | h::t -> (h, String.length h) :: compute_lengths t

let rec make_strings (lst: (char * int) list) : string list =
  match lst with
  | [] -> []
  | (c, n)::t -> String.make n c :: make_strings t

type point = float * float

let distance ((x1, y1): point) ((x2, y2): point) : float =
  Float.sqrt((x2 -. x1) *. (x2 -. x1) +. (y2 -. y1) *. (y2 -. y1))

type triangle = point * point * point

let perimeter ((pt1, pt2, pt3): triangle) : float =
  distance pt1 pt2 +. distance pt2 pt3 +. distance pt1 pt3

let eqf (f1: float) (f2: float) : bool = 
  Float.abs(f1 -. f2) < 0.01

let rec triangle_perimeters (lst: triangle list) : float list =
  match lst with
  | [] -> []
  | h::t -> perimeter h :: triangle_perimeters t

let _ =
  assert(mul (2,1) (3,1) = (6,1));
  assert(mul (2,3) (3,4) = (6,12));
  assert(sub (2,1) (3,1) = (-1,1));
  assert(sub (3,2) (1,3) = (7,6));
  assert(div (1,2) (4,3) = (3,8));
  assert(div (2,5) (3,4) = (8,15));
  assert(simplify (2,6) = (1,3));
  assert(simplify (1,4) = (1,4));
  assert(simplify (2,3) = (2,3));
  assert(simplify (mul (2,3) (3,4)) = (1,2));
  assert(compute_lengths [ "Hello"; "Hi"; "" ] = [ ("Hello", 5); ("Hi", 2); ("", 0) ]);
  assert(compute_lengths [ ] = [ ]);
  assert(make_strings [ ] = [ ]);
  assert(make_strings [ ('a', 3); ('x', 0); ('4', 4) ] = [ "aaa"; ""; "4444" ]);
  assert(Float.abs(distance (1.0, 1.0) (2.0, 2.0) -. 1.414) < 0.001);
  assert(Float.abs(distance (2.0, 2.0) (1.0, 1.0) -. 1.414) < 0.001);
  assert(Float.abs(distance (1.0, 1.0) (3.0, 3.0) -. 2.828) < 0.001);
  assert(Float.abs(distance (2.0, 3.5) (0.2, 4.5) -. 2.059) < 0.001);
  assert(Float.abs(distance (-1.0, -1.0) (0.0, 0.0) -. 1.414) < 0.001);
  assert(Float.abs(perimeter ((1.0, 1.0), (3.0, 1.0), (3.0, 3.0)) -. 6.828) < 0.001);
  assert(Float.abs(perimeter ((1.0, 1.0), (3.0, 2.0), (2.0, 3.0)) -. 5.886) < 0.001)