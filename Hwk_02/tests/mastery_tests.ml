open Mastery

let () =
  assert (huffman_decode_one [false; false; false] tree3 = Some ([], 'e'))
