let rec sum234 (tree: int rree234) : int = 
  match tree with
  | Empty234 -> 0
  | Fork2 (v, t1, t2) -> v + sum234 t1 + sum234 t2
  | Fork3 (v, t1, t2, t3) -> v + sum234 t1 + sum234 t2 + sum234 t3
  | Fork4 (v, t1, t2, t3, t4) -> v + sum234 t1 + sum234 t2 + sum234 t3 + sum234 t4
  
let rec sumRose (tree: int roseTree) : int =
  let rec sumlist ((trees: int rosetree) list) : int =
    match ts with
    | [] -> 0
    | (t, ts) -> sumRose t + sumlist ts
  in match tree with
  | Rose (v, ts) -> v + sumlist ts
  
 
