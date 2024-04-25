open Formula
open Warmup


let rec try_option (env_so_far: subst) (free_vars: string list) (f: formula) : 
           subst option =

  (* The following code should be removed and replaced by your
     implementation of this function.
   *)
  None


let tautology_checker_option (f:formula) : subst option =
  try_option [] (freevars f) f
