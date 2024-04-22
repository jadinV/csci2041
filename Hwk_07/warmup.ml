open Formula

(* Add your implementations of `eval` and `freevars` to the incomplete
   functions below.  The tests require the types for `eval` and 
   `freevars` as determined by the functions below.

   You may add additional helper functions if you find them to be useful.
 *)

let rec remove_duplicates (lst: 'a list) : 'a list =
  match lst with
  | [] -> []
  | x :: xs -> x :: (remove_duplicates (List.filter (fun y -> x <> y) xs))

let rec freevars (e:formula) : string list = 
  match e with
  | Prop s -> [s]
  | And (f1, f2) -> remove_duplicates (freevars f1 @ freevars f2)
  | Or (f1, f2) -> remove_duplicates (freevars f1 @ freevars f2)
  | Not f -> remove_duplicates (freevars f)
  | True -> []
  | False -> []
  | Implies (f1, f2) -> remove_duplicates (freevars f1 @ freevars f2)

let rec eval (f:formula) (env: (string * bool) list) : bool =
  match f with
  | Prop prop -> let rec find_prop (prop: string) (s: (string * bool) list) : bool =
                   match s with
                   | (str, b) :: _ when str = prop -> b
                   | _ :: rest -> find_prop prop rest
                   | [] -> false
                 in find_prop prop env
  | True -> true
  | False -> false
  | And (l, r) -> eval l env && eval r env
  | Or (l, r) -> eval l env || eval r env
  | Not form -> not (eval form env)
  | Implies (l, r) -> raise (Failure "Can not eval implication")
