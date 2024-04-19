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
  | Sub (e1, e2) ->
      ( match eval e1 env, eval e2 env with
        | Int v1, Int v2 -> Int (v1 - v2)
        | _ -> raise (IncorrectType "Sub")
      )
  | Mul (e1, e2) ->
      ( match eval e1 env, eval e2 env with
        | Int v1, Int v2 -> Int (v1 * v2)
        | _ -> raise (IncorrectType "Mul")
      )
  | Div (e1, e2) ->
      ( match eval e1 env, eval e2 env with
        | Int v1, Int v2 when v2 = 0 -> raise (DivisionByZero (Int v1))
        | Int v1, Int v2 -> Int (v1 / v2)
        | _ -> raise (IncorrectType "Div")
      )
  | Neg e1 ->
      ( match eval e1 env with
        | Int v1 -> Int ((-1) * v1)
        | _ -> raise (IncorrectType "Neg")
      )
  | Lt (e1, e2) ->
      ( match eval e1 env, eval e2 env with
        | Int v1, Int v2 -> Bool (v1 < v2)
        | _ -> raise (IncorrectType "Lt")
      )
  | Gt (e1, e2) ->
      ( match eval e1 env, eval e2 env with
        | Int v1, Int v2 -> Bool (v1 > v2)
        | _ -> raise (IncorrectType "Gt")
      )
  | Eq (e1, e2) ->
      ( match eval e1 env, eval e2 env with
        | Int v1, Int v2 -> Bool (v1 == v2)
        | _ -> raise (IncorrectType "Eq")
      )
  | And (e1, e2) ->
      ( match eval e1 env, eval e2 env with
        | Bool v1, Bool v2 -> Bool (v1 && v2)
        | _ -> raise (IncorrectType "And")
      )
  | Or (e1, e2) ->
      ( match eval e1 env, eval e2 env with
        | Bool v1, Bool v2 -> Bool (v1 || v2)
        | _ -> raise (IncorrectType "Or")
      )
  | Not e1 ->
      ( match eval e1 env with
        | Bool v1 -> Bool (not v1)
        | _ -> raise (IncorrectType "Not")
      )
  | Let (str, e1, e2) -> eval e2 [(str, (eval e1 env))]
  | Id str ->
      ( match env with
      | [] -> raise (UnboundVariable str)
      | (s, v) :: _ when s = str -> v
      | _ :: lst -> eval (Id str) lst
      )
