
  
type 'a ltree = Leaf of 'a 
              | Branch of 'a ltree * 'a ltree

val map_ltree : ('a -> 'b) -> 'a ltree  -> 'b ltree
  
val reduce_ltree : ('a -> 'b) -> ('b -> 'b -> 'b) -> 'a ltree -> 'b

val square_all_ltree : int ltree -> int ltree

val lengths_ltree : string ltree -> int ltree

val sum_ltree : int ltree -> int
  
val product_ltree : int ltree -> int
  
type 'a tree = Empty
             | Fork of 'a tree * 'a * 'a tree

val map_tree : ('a -> 'b) -> 'a tree -> 'b tree

val reduce_tree : 'b -> ( 'b -> 'a -> 'b -> 'b) -> 'a tree -> 'b
  
val square_all_tree : int tree -> int tree

val lengths_tree : string tree -> int tree

val sum_tree : int tree -> int
  
val product_tree : int tree -> int

val tree1 : (int tree) tree

val tree2 : (int tree) tree
