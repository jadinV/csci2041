open Formula
open Warmup


let rec try_option (env_so_far: subst) (free_vars: string list) (f: formula) : 
          subst option =
  match f with
  | Prop s -> Some (s, false)
  | And (f1, f2) -> ( match (try_option env_so_far free_vars f1, try_option env_so_far free_vars f2) with
                      | (Some one, Some two) -> combine_subst one two
                      | (Some one, None) -> Some (one)
                      | (None, Some two) -> Some (two)
                      | _ -> None
                    )
  | Implies (f1, f2) -> None
  | Or (f1, f2) -> ( match (try_option env_so_far free_vars f1, try_option env_so_far free_vars f2) with
                     | (Some one, Some two) -> Some (one @ two)
                     | _ -> None
                   )
  | Not f1 -> ( match (try_option env_so_far free_vars f1) with
                | Some one -> Some (List.map (fun (str, b) -> (str, not b)) one)
                | None -> None
              )
  | True -> None
  | False -> Some env_so_far


let tautology_checker_option (f:formula) : subst option =
  try_option [] (freevars f) f
