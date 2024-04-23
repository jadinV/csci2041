type 'a ltree = Leaf of 'a 
              | Branch of 'a ltree * 'a ltree

val map_ltree : ('a -> 'b) -> 'a ltree  -> 'b ltree
  
val reduce_ltree : ('a -> 'b) -> ('b -> 'b -> 'b) -> 'a ltree -> 'b

val max_int_string_pairs : (string * int) list -> (string * int) list
  
val min_ltree : int ltree -> int

val range_ltree : int ltree -> (int * int)

val rev : 'a list -> 'a list
  
val elem : 'a -> 'a list -> bool
  
val sieve : int -> int list -> int list

val range : int -> int list
  
val primes : int list -> int list
