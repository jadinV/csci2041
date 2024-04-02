open Data
open Map
open MapImpl

(* Modules and functors for black box testing.
   -------------------------------------------
 *)

(* The sealed modules for list maps over integer or string keys.
 *)
module ListMapInt = ListMap (IntEq)
module ListMapString = ListMap (StringEq)

(* The sealed modules for tree maps over integer or string keys.
 *)
module TreeMapString = TreeMap (StringOrd)
module TreeMapInt = TreeMap (IntOrd)

(* Blackbox tests for maps with integer keys.
 *)
module IntKeyTests (MapM : S with type key = int) = struct

  module M = MapM
  let m0 : string M.t = M.empty 
  let m1 = M.insert 3 "3" m0
  let m2 = M.insert 2 "2" m1
  let m3 = M.insert 1 "1" m2
  let m4 = M.insert 4 "4" m3
  let m5 = M.insert 6 "6" m4
  let m6 = M.insert 5 "5" m5

  let test () =
    assert (M.lookup 3 m5 = Some "3");
    assert (M.lookup 4 m3 = None);
    assert (M.lookup 7 m6 = None)

end

(* Testing modules *)
module ListMapIntTests = IntKeyTests ( ListMapInt )
module TreeMapIntTests = IntKeyTests ( TreeMapInt )

(* Blackbox tests for maps with string keys.
 *)
module StringKeyTests (MapM : S with type key = string) = struct

  module M = MapM

  let m0 : int M.t = M.empty 
  let m1 = M.insert "A" 1 m0
  let m2 = M.insert "B" 2 m1
  let m3 = M.insert "c" 3 m2
  let m4 = M.insert "d" 4 m3
  let m5 = M.insert "E" 5 m4
  let m6 = M.insert "D" 6 m5

  let test () =
    assert (M.lookup "A" m5 = Some 1);
    assert (M.lookup "a" m5 = Some 1);
    assert (M.lookup "d" m4 = Some 4) ;
    assert (M.lookup "d" m6 = Some 6);
    assert (M.lookup "D" m6 = Some 6);
    assert (M.lookup "X" m3 = None);
    assert (M.lookup "D" m3 = None)

end

(* Testing modules *)
module ListMapStringTests = StringKeyTests ( ListMapString )
module TreeMapStringTests = StringKeyTests ( TreeMapString )


(* Modules and functors for white box testing.
   -------------------------------------------
 *)

module ListMapIntImplTests = struct

  module M = ListMapImpl (IntEq)

  let m0 = M.empty 
  let m1 = M.insert 3 "3" m0
  let m2 = M.insert 2 "2" m1
  let m3 = M.insert 1 "1" m2
  let m4 = M.insert 4 "4" m3
  let m5 = M.insert 6 "6" m4
  let m6 = M.insert 5 "5" m5

  let test () = 
    assert (m0 = []);
    assert (m1 = [(3, "3")]) ;
    assert (m2 = [ (2,"2"); (3,"3") ]);
    assert (M.lookup 3 m5 = Some "3");
    assert (M.lookup 4 m3 = None);
    assert (M.lookup 7 m6 = None)
    
end

module TreeMapStringImplTests = struct

  module M = TreeMapImpl (StringOrd)

  let m0 : int M.t = M.empty 
  let m1 = M.insert "A" 1 m0
  let m2 = M.insert "B" 2 m1
  let m3 = M.insert "c" 3 m2
  let m4 = M.insert "d" 4 m3
  let m5 = M.insert "E" 5 m4
  let m6 = M.insert "D" 6 m5

  let test () =
    assert (m0 = M.Empty);
    assert (m1 = M.Node (M.Empty, "A", 1, M.Empty));
    assert (m3 = M.Node (M.Empty, 
                         "A", 1, 
                         M.Node (M.Empty, 
                                 "B", 2, 
                                 M.Node (M.Empty, "c", 3, M.Empty))
                        ));

    assert (M.lookup "A" m5 = Some 1);
    assert (M.lookup "a" m5 = Some 1);
    assert (M.lookup "d" m4 = Some 4);
    assert (M.lookup "d" m6 = Some 6);
    assert (M.lookup "D" m6 = Some 6);
    assert (M.lookup "X" m3 = None);
    assert (M.lookup "D" m3 = None)
end


(* You may want to copy the pattern above in TreeMapStringImplTests
   for tree maps over interger keys or list maps over string keys.
   These can be quite useful for debugging purposes.
*)

