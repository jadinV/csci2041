(* Hwk 06 Warmup. 

   Extend the functions below to match all of the constructs
   in the type `expr`.

   Some of the parts to be filled in can be found in the 
   functions we developed in class in the `Expressions`
   directory.  If you use work from class please add a note
   to identify the work that is not originally yours.
 *)

type value 
  = Int of int
  | Bool of bool

type environment = (string * value) list
                               
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


exception DivisionByZero of value
exception UnboundVariable of string
exception IncorrectType of string


let rec eval (e:expr) (env: environment) : value =
  match e with
  | Val v -> v

  | Add (e1, e2) ->
     ( match eval e1 env, eval e2 env with
       | Int v1, Int v2 -> Int (v1 + v2)
       | _ -> raise (IncorrectType "Add")
     )

  (* Remove this clause when you are finished implementing this function. *)
  | _ -> raise (Failure "complete eval")


