type expr = Val of value
          | Add of expr * expr
          | Sub of expr * expr
          | Mul of expr * expr
          | Div of expr * expr
          | And of expr * expr
          | Not of expr
          | Let of string * typ * expr * expr
          | Id of string

type 'a result = Result of 'a | Error of string list
and typ = IntT | BoolT

type context = (string * typ) list

let rec lookup (name: string) (cntxt: (string * 'a) list) : 'a =
  match cntxt with
  | [] -> raise (Failure ("Var " ^ name ^ " is not found."))
  | (n', v) :: _ when name = n' -> v
  | _ :: rest -> lookup name rest

let rec type_check (e: expr) (cntxt: context) : typ result =
  match e with
  | Add (e1, e2) -> (match (type_check e1 cntxt, type_check e2 cntxt) with
                     | (Result IntT, Result IntT) -> Result IntT
                     | (Result BoolT, Result IntT) -> Error ["left child of add is Bool"]
                     | (Result IntT, Result BoolT) -> Error ["right child of add is Bool"]
                     | (Result BoolT, Result BoolT) -> Error ["both children of add are Bool"]
                     | (Error msgs, Result IntT) -> Error msgs
                     | (Result IntT, Error msgs) -> Error msgs
                     | (Error msgs1, Error msgs2) -> Error (msgs1 @ msgs2)
                     | (Error msgs, Result BoolT) -> Error (msgs @ ["right child of add is Bool"])
                     | (Result BoolT, Error msgs) -> Error (msgs @ ["left child of add is Bool"])
                    )
  | Let (s, t, e1, e2) -> (match type_check e1 cntxt with
                           | Result t' -> if t = t'
                                          then 
                                          else 
                           | Error msgs -> 
                          )
  | Id s -> lookup s cntxt
  | _ -> failwith "not done"
