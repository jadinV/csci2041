(* Hwk 06 Literacy. 

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
  | Closure of string * expr * environment

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

(* Part 1: free variables *)

let rec freevars (e: expr) : string list =
  match e with
  | Val _ -> []
  | Add (e1, e2) -> freevars e1 @ freevars e2
  | Sub (e1, e2) -> freevars e1 @ freevars e2
  | Mul (e1, e2) -> freevars e1 @ freevars e2
  | Div (e1, e2) -> freevars e1 @ freevars e2
  | Neg e1 -> freevars e1
  | Lt (e1, e2) -> freevars e1 @ freevars e2
  | Gt (e1, e2) -> freevars e1 @ freevars e2
  | Eq (e1, e2) -> freevars e1 @ freevars e2
  | And (e1, e2) -> freevars e1 @ freevars e2
  | Or (e1, e2) -> freevars e1 @ freevars e2
  | Not e1 -> freevars e1
  | Let (str, e1, e2) -> 
      ( match List.exists (fun s -> s = str) (freevars e2) with
        | true -> List.filter (fun s -> s <> str) (freevars e1 @ freevars e2)
        | _ -> (freevars e1 @ freevars e2)
      )
  | Id str -> [str]
  | Lam (str, e1) -> List.filter (fun s -> s <> str) (freevars e1)
  | App (e1, e2) -> freevars e1 @ freevars e2



(* Part 2: evaluation *)
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
  | Lam (str, e1) ->
    ( match eval e1 ((str, Int 0) :: env) with
      | _ -> Closure (str, e1, env)
    )
  | App (e1, e2) -> 
      ( match env with
        | [] -> raise (IncorrectType "App")
        | (str, Closure (var, expr, environ)) :: _ when List.exists (fun x -> x = str) (freevars e1) -> eval expr ((var, eval e2 env) :: environ)
        | _ :: envs -> eval (App (e1, e2)) envs
      )