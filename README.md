# ppx\_unreachable

A PPX that denotes unreachable code and prints descriptive errors when the code is reached

## Install

```opam install ppx_unreachable```

## Example

```ocaml
let test_map x y =
  match List.map (fun x -> 2 * x) [x; y] with
  | [x'; y'] -> "this branch will always be taken"
  | _ -> [%unreachable]

(* Bad example *)
let test_if x =
  if x > 10 then
    "big"
  else if x < 0 then
    "small"
  else
    [%unreachable]

let () = test_if 5 (* unreachable branch hit - test.ml:7 *)
```
