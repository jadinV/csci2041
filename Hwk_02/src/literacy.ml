type 'a tree = Leaf of 'a | Branch of 'a tree * 'a tree

type 'a nonempty_list = One of 'a | Cons of 'a * 'a nonempty_list

type ('key, 'value) maptree =
  | Node of ('key, 'value) maptree * 'key * 'value * ('key, 'value) maptree
  | End

let rec append_nonempty (lst1: 'a nonempty_list) (lst2: 'a nonempty_list) : 'a nonempty_list =
  match (lst1, lst2) with
  | (Cons (x, xs), Cons (y, ys)) -> Cons (x, append_nonempty xs lst2)
  | (One x, _) -> Cons (x, lst2)
  | (Cons (x, xs), One _) -> Cons (x, append_nonempty xs lst2)

let rec normalize_shape (tr: 'a tree) : 'a nonempty_list =
  match tr with
  | Leaf -> 
  | Branch -> 