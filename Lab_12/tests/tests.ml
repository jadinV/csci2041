(* If a test fails with `dune runtests --profile release` try loading the
   tests into utop to experiment with the intermediate values.

   Run  `dune utop --profile release` 
   then `open Tests ;;`

   then `test1 () ;;` or `test2 ();;` etc.

   then, for example, `eval e04 [] ;;` 

   If this was the asssert that failed then evaluating it here in
   utop directly will observe the error. You can explore other values
   and their evaluations in debugging your code.
*)

open Expr

(* Expressions *)
(* some sample expressions *)

(* arithmetic *)
let e01 = Add (Val (Int 3), Val (Int 5))

let e02 = Mul (Add (Val (Int 3), Val (Int 2)), 
               Sub (Val (Int 4), Val (Int 2)))
let e03 = Sub (Val (Int 8), Val (Int 2))
let e04 = Add (Val (Int 8), Neg (Val (Int 2)))


(* relational and logical operations *)
let e05 = Lt (Add (Val (Int 3), Val (Int 5)), Val (Int 10))

let e06 = And (Lt (Val (Int 10), Val (Int 15)),
              Not (Eq (Val (Int 10), Val (Int 8))))

let e07 = Or (Gt (Val (Int 10), Val (Int 15)),
              Not (Eq (Val (Int 10), Val (Int 8))))



(* Let expressions *)

let e08 = Let ("x", Add (Val (Int 3), Val (Int 4)),
              Add (Id "x", Val (Int 5))
           )

   
let e09 = Let ("x", Add (Val (Int 3), Val (Int 4)),
              Lt (Id "x", Val (Int 5))
           )
       
(* ``let x = 3 < 5 in x && let x = 1 + 2 in x = 3 *)
let e10 = Let ("x",
              Lt (Val (Int 3), Val (Int 5)),
              And (Id "x",
                   Let ("x",
                        Add (Val (Int 1), Val (Int 2)),
                        Eq (Id "x", Val (Int 3))
                       )
                  )
             )


(* Functions *)
let e11 = Let ("inc", Lam ("n", Add (Id "n", Val (Int 1))),
               App (Id "inc", Val (Int 2)))

let e12 = Lam ("n", Add (Id "n", Val (Int 1)))

let e13 = Let ("add", 
               Lam ("x", Lam ("y", Add (Id "x", Id "y"))),
               App (App (Id "add", Val (Int 5)), Val (Int 3))
            )

let e14 = If (Eq (Val (Int 4), Val (Int 0)),
              Val (Int 0),
              Val (Int 1)
             )

let e15 = If (Eq (Val (Int 4), Val (Int 4)),
              Val (Bool true),
              Val (Bool false)
             )

let e16 = If (Eq (Val (Int 4), Val (Int 0)),
              Id ("x"),
              Val (Bool false)
             )

let sumToN : expr =
    LetRec ("sumToN",
            Lam ("n",
                 If (Eq (Id "n", Val (Int 0)),
                     Val (Int 0),
                     Add (Id "n",
                          App (Id "sumToN",
                               Sub (Id "n", Val (Int 1))
                              )
                         )
                    )
                ),
            Id "sumToN"
           )

let sumTo4 = App (sumToN, Val (Int 4))


(* Unparse values or the expressions above. *)

let e01_unparse = "(3 + 5)"

let e02_unparse = "((3 + 2) * (4 - 2))"

let e03_unparse = "(8 - 2)"

let e04_unparse = "(8 + ( - 2))"

let e05_unparse = "((3 + 5) < 10)"

let e06_unparse = "((10 < 15) && (not (10 = 8)))"

let e07_unparse = "((10 > 15) || (not (10 = 8)))"

let e08_unparse = "(let x = (3 + 4) in (x + 5))"

let e09_unparse = "(let x = (3 + 4) in (x < 5))"

let e10_unparse = "(let x = (3 < 5) in (x && (let x = (1 + 2) in (x = 3))))"

let e11_unparse = "(let inc = ( fun n -> (n + 1)) in (inc 2))"

let e12_unparse = "(fun n -> (n + 1))"

let e13_unparse = "(let add = (fun x -> (fun y -> (x + y))) in ((add 5) 3))"

let e14_unparse = "(if (4 = 0) then 0 else 1)"

let e15_unparse = "(if (4 = 4) then true else false)"

let e16_unparse = "(if (4 = 0) then x else false)"

let sumToN_unparse = "(let rec sumToN = (fun n -> (if (n = 0) then 0 else (n + (sumToN (n - 1))))) in sumToN)"

let sumTo4_unparse = "((let rec sumToN = (fun n -> (if (n = 0) then 0 else (n + (sumToN (n - 1))))) in sumToN) 4)"


let string_of_chars (chars : char list) : string =
  String.of_seq (List.to_seq chars)

let chars_of_string (str : string) : char list =
  List.of_seq (String.to_seq str)

let rm_spaces (s: string) : string =
  string_of_chars (List.filter (fun c -> c <> ' ') (chars_of_string s))

let tests () =
  assert (rm_spaces (unparse e01) = rm_spaces e01_unparse);
  assert (rm_spaces (unparse e02) = rm_spaces e02_unparse);
  assert (rm_spaces (unparse e03) = rm_spaces e03_unparse);
  assert (rm_spaces (unparse e04) = rm_spaces e04_unparse);
  assert (rm_spaces (unparse e05) = rm_spaces e05_unparse);
  assert (rm_spaces (unparse e06) = rm_spaces e06_unparse);
  assert (rm_spaces (unparse e07) = rm_spaces e07_unparse);
  assert (rm_spaces (unparse e08) = rm_spaces e08_unparse);
  assert (rm_spaces (unparse e09) = rm_spaces e09_unparse);
  assert (rm_spaces (unparse e10) = rm_spaces e10_unparse);
  assert (rm_spaces (unparse e11) = rm_spaces e11_unparse);
  assert (rm_spaces (unparse e12) = rm_spaces e12_unparse);
  assert (rm_spaces (unparse e13) = rm_spaces e13_unparse);
  assert (rm_spaces (unparse e14) = rm_spaces e14_unparse);
  assert (rm_spaces (unparse e15) = rm_spaces e15_unparse);
  assert (rm_spaces (unparse e16) = rm_spaces e16_unparse);
  assert (rm_spaces (unparse sumToN) = rm_spaces sumToN_unparse);
  assert (rm_spaces (unparse sumTo4) = rm_spaces sumTo4_unparse)

