type 'a tree = Leaf of 'a | Branch of 'a tree * 'a tree

type 'a nonempty_list = One of 'a | Cons of 'a * 'a nonempty_list

type ('key, 'value) maptree =
  | Node of ('key, 'value) maptree * 'key * 'value * ('key, 'value) maptree
  | End

let rec append_nonempty (lst1: 'a nonempty_list) (lst2: 'a nonempty_list) : 'a nonempty_list =
  match (lst1, lst2) with
  | (Cons (x, xs), Cons (_, _)) -> Cons (x, append_nonempty xs lst2)
  | (One x, _) -> Cons (x, lst2)
  | (Cons (x, xs), One _) -> Cons (x, append_nonempty xs lst2)

let eq_nonempty (lst1: 'a nonempty_list) (lst2: 'a nonempty_list) : bool =
  lst1 = lst2

let rec normalize_shape (tr: 'a tree) : 'a nonempty_list =
  match tr with
  | Leaf x -> (One x)
  | Branch (x, y) -> append_nonempty (normalize_shape x) (normalize_shape y)

let same_fringe (tr1: 'a tree) (tr2: 'a tree) : bool =
  let first = normalize_shape tr1 in
  let second = normalize_shape tr2 in
  eq_nonempty first second

let rec map_lookup (map: ('key, 'value) maptree) (key: 'key) : 'value option =
  match map with
  | End -> None
  | Node (_, k, v, _) when k = key -> Some v
  | Node (left, k, _, right) -> if map_lookup left key <> None && k >= key 
                                then map_lookup left key
                                else map_lookup right key

let rec map_insert (k: 'key) (v: 'value) (map: ('key, 'value) maptree) : ('key, 'value) maptree =
  match map with
  | Node (left, key, value, r) when k < key -> Node (map_insert k v left, key, value, r)
  | Node (l, key, value, right) when k > key -> Node (l, key, value, map_insert k v right)
  | Node (l, _, _, r) -> Node (l, k, v, r)
  | End -> Node (End, k, v, End)

