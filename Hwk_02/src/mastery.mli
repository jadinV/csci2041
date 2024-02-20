type 'a tree = Leaf of 'a | Branch of 'a tree * 'a tree

val tree1 : char tree
val tree2 : char tree
val tree3 : char tree

val huffman_decode_one : bool list -> 'a tree -> (bool list * 'a) option
val huffman_decode : bool list -> 'a tree -> 'a list option
val huffman_decode_string : bool list -> char tree -> string option

type value = Bool of bool | Int of int

type expr =
  | Lit of value
  | Add of expr * expr
  | Sub of expr * expr
  | Mul of expr * expr
  | Lte of expr * expr
  | Eq of expr * expr
  | If of expr * expr * expr

val eval : expr -> value

type ty = BoolTy | IntTy

val expr_has_type : expr -> ty -> bool
