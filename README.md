# ppx\_unreachable

A PPX that denotes unreachable code and prints descriptive errors when the code is reached

## Install

```opam install ppx_unreachable```

## Example

Obviously, this is a case where unreachable is not applicable, however the applicable cases are not demonstratable.

```ocaml
let test_if x =
  if x > 10 then
    "big"
  else if x < 0 then
    "small"
  else
    [%unreachable]

let () = test_if 5 (* unreachable branch hit - test.ml:7 *)
```
