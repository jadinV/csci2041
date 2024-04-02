open Tests

(* Run the black box tests *)
let () = ListMapIntTests.test ()
let () = TreeMapIntTests.test ()

let () = ListMapStringTests.test ()
let () = TreeMapStringTests.test ()


(* Run the white box tests *)
let () = ListMapIntImplTests.test ()
let () = TreeMapStringImplTests.test ()
