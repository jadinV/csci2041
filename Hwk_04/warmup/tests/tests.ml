(* Blackbox tests for sets *)

(* If a test fails with `dune runtests` try loading the
   tests into utop to experiment with the intermediate values.

   Run  `dune utop` 
   then `open Tests ;;`
   then `open ListSetTests ;;`
   or
        `open TreeSetTests ;;`
   then `open S ;;`
   then `test1 () ;;` or `test2 ();;` etc.
   then `size s4 ;;` 
   - This observes the error. You can create new sets and
     experiment with them as well.
   - Note that we do not see the representation of the data
   - We do not know what `s4` is as a list or tree.
   - We can remove the `: S` signature spec from ListSet thus making it open
     so that the representation can be seen. But this unsatifactory as we 
     don't want to modify this file whenever we run `dune utop`.
   - The code you turn in must have the `: S` signature specification on the 
     definition of `ListSet` and `TreeSet`.
   - We want ListSet to keep some elements abstract.
*)

module Tests (SetImpl: Set.S) = struct

  module S = SetImpl
 
  let s0 = S.empty
  let s1 = S.add 1 s0
  let s2 = S.add 2 s1
  let s3 = S.add 3 s2
  let s4 = S.add 2 s3

  let test1 () = 
    assert (S.elem 1 s1);
    assert (S.elem 2 s2);
    assert (S.elem 3 s3);
    assert (S.elem 2 s4)

  let test2 () = 
    assert (not (S.elem 4 s0));
    assert (not (S.elem 2 s1));
    assert (not (S.elem 3 s2))

  let test3 () = 
    assert (S.size s0 = 0);
    assert (S.size s3 = 3);
    assert (S.size s4 = 3)

end

module ListSetTests = Tests (Set.ListSet)
module TreeSetTests = Tests (Set.TreeSet)
