type 'a tree = Leaf of 'a | Branch of 'a tree * 'a tree

type 'a nonempty_list = One of 'a | Cons of 'a * 'a nonempty_list

type ('key, 'value) maptree =
  | Node of ('key, 'value) maptree * 'key * 'value * ('key, 'value) maptree
  | End

let append_nonempty (lst1: 'a nonempty_list) (lst2: 'a nonempty_list) : 'a nonempty_list =
  match (lst1, lst2) with
  | (Cons (x * xs), Cons (y * ys)) -> 