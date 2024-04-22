
open Formula
open Warmup

let test_freevars () =
  assert (freevars (And ( Prop "P", Prop "Q")) = ["P"; "Q"]);
  assert (freevars (And ( Prop "Q", Prop "P")) = ["Q"; "P"]);

  assert (List.length (freevars nt3) = 3);

  assert (List.mem "P" (freevars nt3));
  assert (List.mem "Q" (freevars nt3));
  assert (List.mem "R" (freevars nt3))

let test_eval () =
  assert (eval (And ( Prop "P", Prop "Q")) [("P",true); ("Q",false)] =
            false);
  assert (eval (And ( Prop "P", Prop "Q")) [("P",true); ("Q",true)] =
            true)

