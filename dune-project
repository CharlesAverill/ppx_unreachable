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
 (synopsis "A tool for denoting unreachable control flow paths")
 (description "A PPX that denotes unreachable code and prints descriptive errors when the code is reached")
 (depends 
	ocaml 
	dune 
	(ppxlib (>= 0.36))))

