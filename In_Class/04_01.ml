type expr = Add of expr * expr
          | Sub of expr * expr
          | Mul of expr * expr
          | Div of expr * expr
          | Num of int

let rec string_of_expr (e: exrp) : string = 
  match e with
  | Num n -> string_of_int n
  | Add (e1, e2) -> "(" ^ string_of_expr e1 ^ " + " string_of_expr e2 ^ ")"
  | Sub (e1, e2) -> "(" ^ string_of_expr e1 ^ " - " string_of_expr e2 ^ ")"
  | Mul (e1, e2) -> "(" ^ string_of_expr e1 ^ " * " string_of_expr e2 ^ ")"
  | Div (e1, e2) -> "(" ^ string_of_expr e1 ^ " / " string_of_expr e2 ^ ")"

let rec eval (e: expr) (env: environment) : int =
  match e with
  | Num n -> string_of_int n
  | Add (e1, e2) -> eval e1 env + eval e2 env
  | Sub (e1, e2) -> eval e1 env - eval e2 env
  | Mul (e1, e2) -> eval e1 env * eval e2 env
  | Div (e1, e2) -> eval e1 env / eval e2 env
  | Id s -> lookup s env
  | Let (s, e1, e2) -> 
      let v1 = eval e1 env
      in eval e2 ((s, v1) :: env) 

let rec lookup (name: string) (env: (string * int) list) : int =
  match env with
  | [] -> raise, (Faiilure ("Var " ^ name ^ " is not found."))
  | (n', v) :: rest when name = n' -> v
  | _ :: rest -> lookup name rest

