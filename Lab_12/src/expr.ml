
type value 
  = Int of int
  | Bool of bool

and environment = (string * value) list
                               
and expr 
  = Val of value

  | Add of expr * expr
  | Sub of expr * expr
  | Mul of expr * expr
  | Div of expr * expr
  | Neg of expr 

  | Lt  of expr * expr
  | Gt  of expr * expr
  | Eq  of expr * expr
  | And of expr * expr
  | Or  of expr * expr
  | Not of expr

  | Let of string * expr * expr
  | Id  of string

  | Lam of string * expr
  | App of expr * expr

  | LetRec of string * expr * expr
  | If of expr * expr * expr


let rec unparse (e: expr) : string =
  match e with
  | Add (e1, e2) ->
     "(" ^ unparse e1 ^ " + " ^ unparse e2 ^ ")"

  | _ -> raise (Failure "finish this function")
