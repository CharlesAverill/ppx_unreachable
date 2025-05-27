open Ppxlib
open Ast_builder.Default

(* Expand [%unreachable] into a runtime failure *)
let expand_unreachable ~loc ~path = [%expr failwith "unreachable branch hit"]

let unreachable_extension =
  Extension.declare "unreachable" Extension.Context.expression
    Ast_pattern.(pstr nil)
    expand_unreachable

let rule = Context_free.Rule.extension unreachable_extension

let () = Driver.register_transformation "ppx_unreachable" ~rules:[rule]
