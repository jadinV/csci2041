open Formula
open Warmup
open Literacy 

let test_option () =
  assert ( tautology_checker_option t1 = None );
  assert ( tautology_checker_option t2 = None );
  assert ( tautology_checker_option t3 = None );
  assert ( tautology_checker_option nt1 <> None );
  assert ( tautology_checker_option nt1 = 
             Some [ ("Q", false); ("P", false) ]  ||
           tautology_checker_option nt1 = 
             Some [ ("P", false); ("Q", false) ]  );

  assert ( match tautology_checker_option nt2 with
           | None -> false
           | Some s -> 
              List.mem (List.sort compare s)
                [ [ ("P", false); ("Q", false) ];
                  [ ("P", true) ; ("Q", false) ];
                  [ ("P", false); ("Q", true)  ]
                ] )


let test_try_option () =
  assert ( try_option [] (freevars t1) t1 = None );
  assert ( try_option [] (freevars t2) t2 = None );
  assert ( try_option [] (freevars t3) t3 = None );
  assert ( try_option [] (freevars nt1) nt1 = 
             Some [ ("Q", false); ("P", false) ] )


