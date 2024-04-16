type formula = And  of formula * formula
	           | Implies of formula * formula
             | Or of formula * formula
	           | Not of formula 
	           | Prop of string
	           | True
             | False

type subst = (string * bool) list

let show_list (show: 'a -> string) (lst: 'a list) : string =
  let rec sl lst =
    match lst with
    | [] -> ""
    | [x] -> show x
    | x::xs -> show x ^ "; " ^ sl xs
  in "[ " ^ sl lst ^ " ]"

let show_string_bool_pair (s, b) =
  "(\"" ^ s ^ "\"," ^ (if b then "true" else "false") ^ ")"

let show_subst (s: subst) : string = show_list show_string_bool_pair s

let string_of_chars (chars : char list) : string =
  String.of_seq (List.to_seq chars)

let chars_of_string (str : string) : char list =
  List.of_seq (String.to_seq str)

let rm_duplicates (lst: 'a list) : 'a list =
  let collect_unique elem to_keep =
    if List.mem elem to_keep then to_keep else elem::to_keep
  in List.fold_right collect_unique lst []

let rec eval (f: formula) (s: subst) : bool =
  match f with
  | Prop prop -> let rec find_prop (prop: string) (s: subst) : bool =
                   match s with
                   | (str, b) :: _ when str = prop -> b
                   | _ :: rest -> find_prop prop rest
                   | [] -> false
                 in find_prop prop s
  | True -> true
  | False -> false
  | And (l, r) -> eval l s && eval r s
  | Or (l, r) -> eval l s || eval r s
  | Not form -> not (eval form s)
  | Implies (l, r) -> raise (Failure "Can not eval implication")
