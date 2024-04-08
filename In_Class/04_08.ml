type expr = Num of int
          | Add of expr * expr
          | Sub of expr * expr
          | Mul of expr * expr
          | Div of expr * expr
          | Let of string * expr * expr
          | Id of string
          | App of expr * expr
          | Fun of string * expr

let e1 = Add (Num 3, Num 2)

let e2 = Let ("inc", Fun ("x", Add (Id "x", Num 1)), App (Id "inc" , Num 4))

let e3 = Let ("add", Fun ("x", Fun ("y", Add (Id "x", Id "y"))), App (App (Id "add", Num 3), Num 2))

type typ = IntT
         | BoolT
         | FunT of typ * typ

