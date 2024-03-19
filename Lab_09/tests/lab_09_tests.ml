open Lab_09

module PureApp = MakeApp (PureIO)

let test_app (input : string list) (expected : string list) : unit =
  let ctx = PureIO.new_ctx input in
  let ctx' = PureApp.run ctx in
  assert (PureIO.read_put_buffer ctx' = expected)

let () =
  test_app
    [ "3"; "4"; "2"; "1" ]
    [
      "How many numbers do you want to square?";
      "Please enter a number (1/3)";
      "Please enter a number (2/3)";
      "Please enter a number (3/3)";
      "Your squared numbers are:";
      "16";
      "4";
      "1";
    ]
