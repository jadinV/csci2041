open Map
open MapImpl

(* Blackbox tests.
   These tests take a Map that satisies the map signature S.
   We can thus only run tests that see the elements of S, not
   any internal functions or representation of map values.

   The advantage is that by packaging them as a functor we can run 
   these tests on different implementation of Map.
 *)
module Tests (MapM: S) = struct

  module M = MapM (* this is required - one can open M in utop and play *)

  let m0 = M.empty 
  let m1 = M.insert 3 "3" m0 
  let m2 = M.insert 2 "2" m1 
  let m3 = M.insert 1 "1" m2 
  let m4 = M.insert 4 "4" m3 
  let m5 = M.insert 2 "6" m4 
  let m6 = M.insert 5 "5" m5 

  let test () =
    assert (M.lookup 3 m5 = Some "3");
    assert (M.lookup 2 m2 = Some "2");
    assert (M.lookup 2 m5 = Some "6");
    assert (M.lookup 4 m3 = None);
    assert (M.lookup 7 m6 = None)

end

module ListMapTests = Tests (ListMap) 
module TreeMapTests = Tests (TreeMap) 


(* Some whitebox tests for Lists. Open these in 
   utop to explore errors in your code.
 *)

module ListMapImplTests = struct

  module M = ListMapImpl
  let m0 = M.empty 
  let m1 = M.insert 3 "3" m0 
  let m2 = M.insert 2 "2" m1 
  let m3 = M.insert 1 "1" m2 
  let m4 = M.insert 4 "4" m3 
  let m5 = M.insert 2 "6" m4 
  let m6 = M.insert 5 "5" m5 

  let test () =
    assert (m0 = []);
    assert (m1 = [(3, "3")]) ;
    assert (m2 = [ (2,"2"); (3,"3") ]);
    assert (M.lookup 3 m5 = Some "3");
    assert (M.lookup 2 m2 = Some "2");
    assert (M.lookup 2 m5 = Some "6");
    assert (M.lookup 4 m3 = None);
    assert (M.lookup 7 m6 = None)

end


(* Some whitebox tests for Trees. Open these in 
   utop to explore errors in your code.
 *)

module TreeMapImplTests = struct

  module M = TreeMapImpl
  let m0 = M.empty
  let m1 = M.insert 3 "3" m0
  let m2 = M.insert 2 "2" m1
  let m3 = M.insert 1 "1" m2
  let m4 = M.insert 4 "4" m3
  let m5 = M.insert 2 "6" m4
  let m6 = M.insert 5 "5" m5

  let test() =
    assert (m0 = M.Empty);
    assert (m1 = M.Node (M.Empty, 3, "3", M.Empty));
    assert (M.lookup 3 m5 = Some "3");
    assert (M.lookup 2 m2 = Some "2");
    assert (M.lookup 2 m5 = Some "6");
    assert (M.lookup 4 m3 = None);
    assert (M.lookup 7 m6 = None)
end


