open Ppxlib
open Ast_builder.Default

(* Expand [%unreachable] into a runtime failure *)
let expand_unreachable ~loc ~path =
  let filename = loc.loc_start.pos_fname in
  let line_num = loc.loc_start.pos_lnum in
  [%expr
    failwith
      ( "unreachable branch hit - " ^ [%e estring ~loc filename] ^ ":"
      ^ string_of_int [%e eint ~loc line_num] )]

let unreachable_extension =
  Extension.declare "unreachable" Extension.Context.expression
    Ast_pattern.(pstr nil)
    expand_unreachable

let rule = Context_free.Rule.extension unreachable_extension

let () = Driver.register_transformation "ppx_unreachable" ~rules:[rule]
