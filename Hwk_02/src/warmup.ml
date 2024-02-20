type 'a tree = Leaf of 'a | Branch of 'a tree * 'a tree

let rec tree_product (t: int tree) : int =
  match t with
  | Leaf(v) -> v
  | Branch (t1, t2) -> tree_product t1 * tree_product t2

let rec tree_min (t: int tree) : int =
  match t with
  | Leaf(v) -> v
  | Branch(t1, t2) -> if tree_min t1 > tree_min t2
                      then tree_min t2
                      else tree_min t1

let rec tree_max (t: int tree) : int =
  match t with
  | Leaf(v) -> v
  | Branch(t1, t2) -> if tree_max t1 < tree_max t2
                      then tree_max t2
                      else tree_max t1

let tree_range (t: int tree) : int * int =
  (tree_min t, tree_max t)

let tree_depth_range (t: 'a tree) : int * int =
  let rec helper (tr: 'a tree) : int =
    match tr with
    | Leaf(_) -> 0
    | Branch (t1, t2) when helper t1 > helper t2 -> helper t1 + 1
    | Branch (t1, t2) -> helper t2 + 1
  in 
  match t with
  | Leaf(_) -> (1, 1)
  | Branch(_, _) -> let depth = helper t in (depth, depth + 1)

let rec same_shape (l: 'a tree) (r: 'a tree) : bool =
  match (l, r) with
  | (l, r) when tree_depth_range l != tree_depth_range r -> false
  | (Leaf  _), (Leaf _) -> true
  | (Leaf  _), (Branch (_, _)) -> false
  | (Branch (_, _), Leaf _) -> false
  | (Branch (t1, t2), Branch (t3, t4)) -> same_shape t1 t3 && same_shape t2 t4
