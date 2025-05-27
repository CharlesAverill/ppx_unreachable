# ppx\_unreachable

A PPX that denotes unreachable code and prints descriptive errors when the code is reached

## Example

```ocaml
let test_if x =
  if x > 10 then
    "big"
  else if x < 0 then
    "small"
  else
    [%unreachable]
```
