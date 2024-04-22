open Formula
open Warmup
open Mastery

let test_exception () =
  assert ( tautology_checker_excn t1 = None );
  assert ( tautology_checker_excn t2 = None );
  assert ( tautology_checker_excn t3 = None );
  assert ( tautology_checker_excn nt1 <> None );
  assert ( tautology_checker_excn nt1 = Some [ ("Q", false); ("P", false) ] ||
           tautology_checker_excn nt1 = Some [ ("P", false); ("Q", false) ] );
  assert ( tautology_checker_excn nt2 <> None )

let test_try_exception () =
  assert (try_exception [] (freevars t1) t1 = ());
  assert (try_exception [] (freevars t2) t2 = ());
  assert (try_exception [] (freevars t3) t3 = ());

  assert (try try_exception [] (freevars nt1) nt1; false with
          | FoundCounterExample s -> 
             List.sort compare s = [ ("P", false); ("Q", false) ])
