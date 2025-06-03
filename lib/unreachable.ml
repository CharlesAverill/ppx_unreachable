open Ppxlib
open Ast_builder.Default

(* Expand [%unreachable] into a runtime failure with file + line info *)
let expand_unreachable ~loc ~path =
  let filename = loc.loc_start.pos_fname in
  let line_num = loc.loc_start.pos_lnum in
  [%expr
    failwith
      ( "unreachable branch hit - " ^ [%e estring ~loc filename] ^ ":"
      ^ string_of_int [%e eint ~loc line_num] )]

(* Expand [%unreachable "message"] into a runtime failure with message + location *)
let expand_unreachable_msg ~loc ~path msg =
  [%expr failwith ("unreachable branch hit - " ^ [%e estring ~loc msg])]

(* Extension for [%unreachable] *)
let unreachable_extension =
  Extension.declare "unreachable" Extension.Context.expression
    Ast_pattern.(pstr nil)
    expand_unreachable

(* Extension for [%unreachable "message"] *)
let unreachable_msg_extension =
  Extension.declare "unreachable_msg" Extension.Context.expression
    Ast_pattern.(single_expr_payload (estring __))
    expand_unreachable_msg

let rule = Context_free.Rule.extension unreachable_extension

let rule_msg = Context_free.Rule.extension unreachable_msg_extension

let () = Driver.register_transformation "ppx_unreachable" ~rules:[rule; rule_msg]
