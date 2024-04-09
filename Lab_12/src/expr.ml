
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
  | Val x -> (match x with
              | Int i -> string_of_int i
              | Bool b -> string_of_bool b
             )
  | Add (e1, e2) ->
      "(" ^ unparse e1 ^ " + " ^ unparse e2 ^ ")"
  | Sub (e1, e2) ->
      "(" ^ unparse e1 ^ " - " ^ unparse e2 ^ ")"
  | Mul (e1, e2) ->
      "(" ^ unparse e1 ^ " * " ^ unparse e2 ^ ")"
  | Div (e1, e2) ->
      "(" ^ unparse e1 ^ " / " ^ unparse e2 ^ ")"
  | Neg (e1) ->
      "( - " ^ unparse e1 ^ ")"
  | Lt (e1, e2) ->
      "(" ^ unparse e1 ^ " < " ^ unparse e2 ^ ")"
  | Gt (e1, e2) ->
      "(" ^ unparse e1 ^ " > " ^ unparse e2 ^ ")"
  | Eq (e1, e2) ->
      "(" ^ unparse e1 ^ " = " ^ unparse e2 ^ ")"
  | And (e1, e2) ->
      "(" ^ unparse e1 ^ " && " ^ unparse e2 ^ ")"
  | Or (e1, e2) ->
      "(" ^ unparse e1 ^ " || " ^ unparse e2 ^ ")"
  | Not e1 ->
      "(not " ^ unparse e1 ^ ")"
  | Let (str, e1, e2) ->
      "(let " ^ str ^ " = " ^ unparse e1 ^ " in " ^ unparse e2 ^ ")"
  | Id str -> str
  | Lam (str, e1) ->
      "(fun " ^ str ^ " -> " ^ unparse e1 ^ ")"
  | App (e1, e2) -> 
      "(" ^ unparse e1 ^ " " ^ unparse e2 ^ ")"
  | LetRec (str, e1, e2) ->
      "(let rec " ^ str ^ " = " ^ unparse e1 ^ " in " ^ unparse e2 ^ ")"
  | If (e1, e2, e3) ->
      "(if " ^ unparse e1 ^ " then " ^ unparse e2 ^ " else " ^ unparse e3 ^ ")"
