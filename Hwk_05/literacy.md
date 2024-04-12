## Prove the associativity of append for nonempty lists

### 1. Principle of Induction

This proof uses induction on the `nonempty` type, so the principle of induction is:
for all `xs : 'a nonempty`, `P(xs)` if
- `P(One hd)`
- for all `hd : 'a` and `tl : 'a nonempty`, `P(tl) => P(Cons hd tl)`

### 2. Base case to Prove

`app One m (app Cons (n, l2) Cons (p, l3)) = app (app One m Cons (n, l2)) Cons (p, l3)`

### 3. Proof of Base Case 

`app One m (app Cons (n, l2) Cons (p, l3))`

- by def of app

`= Cons (m, app Cons (n, l2) Cons (p, l3))`

- by def of app

`= app (Cons (m, Cons (n, l2))) Cons (p, l3)`

- by def of app

`= app (app One m Cons (n, l2)) Cons (p, l3)`

### 4. Inductive Case to Prove

`app Cons (m, l1) (app Cons (n, l2) Cons (p, l3)) = app (app Cons (m, l1) Cons (n, l2)) Cons (p, l3)`

### 5. Inductive Hypothesis

`app l1 (app Cons (n, l2) Cons (p, l3)) = app (app l1 Cons (n, l2)) Cons (p, l3)`

### 6. Proof of Inductive Case

`app Cons (m, l1) (app Cons (n, l2) Cons (p, l3))`

- by def of app

`= Cons (m, app l1 (app Cons (n, l2) Cons (p, l3)))`

- by inductive hypothesis

`= Cons (m, app (app l1 Cons (n, l2))) Cons (p, l3)`

- by def of app

`= app (Cons (m, app l1 Cons (n, l2))) Cons (p, l3)`

- by def of app

`= app (app Cons (m, l1) Cons (n, l2)) Cons (p, l3)`

## Prove the relationship between reverse and append for nonempty lists

### 1. Principle of Induction

This proof uses induction on the `nonempty` type, so the principle of induction is:
for all `xs : 'a nonempty`, `P(xs)` if
- `P(One hd)`
- for all `hd : 'a` and `tl : 'a nonempty`, `P(tl) => P(Cons hd tl)`

### 2. Base case to Prove

`rev (app One m Cons (n, l2)) = app (rev Cons (n, l2)) (rev One m)`

### 3. Proof of Base Case 

`rev (app One m Cons (n, l2))`

- by def of app

`= rev (Cons (m, Cons (n, l2)))`

- by def of rev

`= app (rev Cons (n, l2)) One m`

- by def of rev

`= app (app (rev l2) One n) One m`

- by def of rev

`= app (rev Cons (n, l2)) One m`

- by def of rev

`= app (rev Cons (n, l2)) (rev One m)`

### 4. Inductive Case to Prove

`rev (app Cons (m, l1) Cons (n, l2)) = app (rev Cons (n, l2)) (rev Cons (m, l1))`

### 5. Inductive Hypothesis

`app l1 (app Cons (n, l2) Cons (p, l3)) = app (app l1 Cons (n, l2)) Cons (p, l3)`

### 6. Proof of Inductive Case

`rev (app Cons (m, l1) Cons (n, l2))`

- by some bullshit

`= app (rev Cons (n, l2)) (rev Cons (m, l1))`