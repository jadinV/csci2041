type 'a tree = Leaf of 'a | Branch of 'a tree * 'a tree

type 'a nonempty_list
  = One of 'a
  | Cons of 'a * 'a nonempty_list

val append_nonempty : 'a nonempty_list -> 'a nonempty_list -> 'a nonempty_list
val normalize_shape : 'a tree -> 'a nonempty_list
val eq_nonempty : 'a nonempty_list -> 'a nonempty_list -> bool
val same_fringe : 'a tree -> 'a tree -> bool

type ('key, 'value) maptree =
  | Node of ('key, 'value) maptree * 'key * 'value * ('key, 'value) maptree
  | End

val map_lookup : ('key, 'value) maptree -> 'key -> 'value option
val map_insert : 'key -> 'value -> ('key, 'value) maptree -> ('key, 'value) maptree
