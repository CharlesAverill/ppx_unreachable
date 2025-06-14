let test_if x =
  if x > 10 then
    "big"
  else if x < 0 then
    "small"
  else
    [%unreachable_msg "test_if"]

let test_match x = match x with [] -> 0 | [1] -> 1 | _ -> [%unreachable]

let () =
  ignore (test_if 11) ;
  ignore (test_if (-1)) ;
  try ignore (test_if 5) with Failure s -> print_endline ("test_if pass: " ^ s)

let () =
  ignore (test_match []) ;
  ignore (test_match [1]) ;
  try ignore (test_match [1; 2; 3])
  with Failure s -> print_endline ("test_match pass: " ^ s)
