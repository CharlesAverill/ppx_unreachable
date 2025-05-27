(lang dune 3.9)

(name ppx_unreachable)

(generate_opam_files true)

(source
 (github CharlesAverill/ppx_unreachable))

(authors "Charles Averill")

(maintainers "Charles Averill")

(license MIT)

(documentation https://github.com/CharlesAverill/ppx_unreachable)

(package
 (name ppx_unreachable)
 (synopsis "A PPX that denotes unreachable code and prints descriptive errors when the code is reached")
 (description "A PPX that denotes unreachable code and prints descriptive errors when the code is reached")
 (depends ocaml (dune :with-test) (alcotest :with-test) (ocamlformat :with-test) (dune-release :with-test) ppxlib))

