type loc = L | R
type state = loc * loc * loc * loc
let final (s: state) : bool = s = (R, R, R, R)

let ok_state ((p, w, g, c): state) : bool =
  (g <> c && w <> g) || (p = g)

let other_side l =
  match l with
  | L -> R
  | R -> l

let moves (s: state) : state list =
  ...

let corssing_v1 () : state list option = 
  ...
