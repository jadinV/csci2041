## Prove the associativity of append for nonempty lists

### 1. Principle of Induction

This proof uses induction on the `nonempty` type, so the principle of induction is:
for all `xs : 'a nonempty`, `P(xs)` if
- `P(One hd)`
- for all `hd : 'a` and `tl : 'a nonempty`, `P(tl) => P(Cons hd tl)`

### 2. Base Case to Prove

`app One m (app Cons (n, l2) Cons (p, l3)) = app (app One m Cons (n, l2)) Cons (p, l3)`

### 3. Proof of Base Case 

`app One m (app Cons (n, l2) Cons (p, l3))`

- by definition of app

`= Cons (m, app Cons (n, l2) Cons (p, l3))`

- by definition of app

`= app (Cons (m, Cons (n, l2))) Cons (p, l3)`

- by definition of app

`= app (app One m Cons (n, l2)) Cons (p, l3)`

### 4. Inductive Case to Prove

`app Cons (m, l1) (app Cons (n, l2) Cons (p, l3)) = app (app Cons (m, l1) Cons (n, l2)) Cons (p, l3)`

### 5. Inductive Hypothesis

`app l1 (app Cons (n, l2) Cons (p, l3)) = app (app l1 Cons (n, l2)) Cons (p, l3)`

### 6. Proof of Inductive Case

`app Cons (m, l1) (app Cons (n, l2) Cons (p, l3))`

- by definition of app

`= Cons (m, app l1 (app Cons (n, l2) Cons (p, l3)))`

- by inductive hypothesis

`= Cons (m, app (app l1 Cons (n, l2))) Cons (p, l3)`

- by definition of app

`= app (Cons (m, app l1 Cons (n, l2))) Cons (p, l3)`

- by definition of app

`= app (app Cons (m, l1) Cons (n, l2)) Cons (p, l3)`

## Prove the relationship between reverse and append for nonempty lists

### 1. Principle of Induction

This proof uses induction on the `nonempty` type, so the principle of induction is:
for all `xs : 'a nonempty`, `P(xs)` if
- `P(One hd)`
- for all `hd : 'a` and `tl : 'a nonempty`, `P(tl) => P(Cons hd tl)`

### 2. Base Case to Prove

`rev (app One m Cons (n, l2)) = app (rev Cons (n, l2)) (rev One m)`

### 3. Proof of Base Case 

`rev (app One m Cons (n, l2))`

- by definition of app

`= rev (Cons (m, Cons (n, l2)))`

- by definition of rev

`= app (rev Cons (n, l2)) One m`

- by definition of rev

`= app (app (rev l2) One n) One m`

- by definition of rev

`= app (rev Cons (n, l2)) One m`

- by definition of rev

`= app (rev Cons (n, l2)) (rev One m)`

### 4. Inductive Case to Prove

`rev (app Cons (hd, tl) l2) = app (rev l2) (rev Cons (hd, tl))`

### 5. Inductive Hypothesis

`rev (app tl l2) = app ((rev l2) rev tl)`

### 6. Proof of Inductive Case

`rev (app Cons (hd, tl) l2)`

- by definition of app

`= rev (Cons (hd, app tl l2))`

- by definition of rev

`= app (rev (app tl l2) (One hd))`

- by inductive hypothesis

`= app (app ((rev l2) rev tl) (One hd))`

- by Prove the associativity of append for nonempy lists

`= app (rev l2) (app (rev tl) (One hd))`

- by definition of rev

`= app (rev l2) (rev Cons (hd, tl))`

## Consider purity

### Example

```
let f (x: int) : int = print_int (2 * x);
                       print_endline "";
                       2 * x
```

```
let g (x: int) : int = print_int (x * x);
                       print_endline "";
                       x * x
```

`let xs = [1; 2; 3; 4; 5]`

### Scenario 1 `map f (map g xs)`

Here the values in `xs` get squared and printed through the whole list, then doubled and printed through the whole list. The output is given below.

```
25
16
9
4
1
50
32
18
8
2
- : int list = [2; 8; 18; 32; 50]
```

### Scenario 2 `map (fun x -> f (g x)) xs`

Here the values in `xs` get squared and printed then doubled and printed one element at a time through the list. The output is given below.

```
25
50
16
32
9
18
4
8
1
2
- : int list = [2; 8; 18; 32; 50]
```
