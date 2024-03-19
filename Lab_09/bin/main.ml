open Lab_09

module App = MakeApp (CheckedIO)

let () =
  let ctx = CheckedIO.new_ctx () in
  let ctx' = App.run ctx in
  ignore ctx'
