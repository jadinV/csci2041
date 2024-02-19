type 'a tree = Leaf of 'a | Branch of 'a tree * 'a tree

type 'a nonempty_list = One of 'a | Cons of 'a * 'a nonempty_list

let normalize_shape (tr: 'a tree) : 'a nonempty_list =
  