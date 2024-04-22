open Formula
open Warmup


exception FoundCounterExample of subst

let rec try_exception (env_so_far: subst) (free_vars: string list) 
          (f: formula) : unit =

  (* The following code should be removed and replaced by your
     implementation of this function.
   *)
  ()



let tautology_checker_excn (f:formula) : subst option =
  try try_exception [] (freevars f) f; None with
  | FoundCounterExample s -> Some s


