.PHONY: default build install uninstall test clean fmt
.IGNORE: fmt

OPAM ?= opam
OPAM_EXEC ?= $(OPAM) exec --
DUNE ?= dune

default: build

fmt:
	$(OPAM_EXEC) $(DUNE) build @fmt
	$(OPAM_EXEC) $(DUNE) promote

build: fmt
	$(OPAM_EXEC) $(DUNE) build

install:
	$(OPAM_EXEC) $(DUNE) install

uninstall:
	$(OPAM_EXEC) $(DUNE) uninstall

clean:
	$(OPAM_EXEC) $(DUNE) clean
	git clean -dfXq

test: fmt
	$(OPAM_EXEC) $(DUNE) runtest

release: fmt test
	$(OPAM_EXEC) dune-release bistro

testf: fmt
	$(OPAM_EXEC) $(DUNE) runtest -f

debug: build
	$(OPAM_EXEC) ocamldebug _build/default/ppx_unreachable/main.bc

DOCS_PATH=docs/
DOCS_NAME=ppx_unreachable
DOCS_DESCR=A PPX that denotes unreachable code and prints descriptive errors when the code is reached
DOCS_INDEX_TITLE=$(DOCS_NAME) - $(DOCS_DESCR)
define DOCS_EMBED
<meta content="$(DOCS_NAME)" property="og:title" />\
<meta content="$(DOCS_DESCR)" property="og:description" />\
<meta content="https://github.com/CharlesAverill/ppx_unreachable" property="og:url" />
endef

cleandocs:
	if [ ! -d $(DOCS_PATH) ]; then \
		mkdir $(DOCS_PATH); \
	fi
	rm -rf $(DOCS_PATH)module $(DOCS_PATH)docs $(DOCS_PATH)odoc.support $(DOCS_PATH)index.html

docs: cleandocs build
	$(OPAM_EXEC) $(DUNE) build @doc
	mv -f _build/default/_doc/_html/* $(DOCS_PATH)
	rm -f $(DOCS_PATH)index.html
	mv $(DOCS_PATH)ppx_unreachable/ppx_unreachable.html $(DOCS_PATH)index.html
	mv $(DOCS_PATH)ppx_unreachable $(DOCS_PATH)module
	
	@echo "Preparing Index\n--------------"
	# Header
	sed -i 's/<title>.*<\/title>/<title>$(DOCS_INDEX_TITLE)<\/title>/g' $(DOCS_PATH)index.html
	sed -i 's@</head>@$(DOCS_EMBED)\n</head>@g' $(DOCS_PATH)index.html
	sed -i 's/..\/odoc.support/odoc.support/g' $(DOCS_PATH)index.html
	# Body
	sed -i "s@<nav class="odoc-nav">.*gbcamel</nav>@@g" $(DOCS_PATH)index.html

push: cleandocs build
	@read -p "Commit message: " input; \
	if [ -z "$input" ]; then \
		echo "Error: Please provide a valid commit message."; \
		exit 1; \
	fi; \
	git add . && git commit -m "$$input" && git push origin main
