default: link

deps: deps-kevm deps-npm

deps-kevm:
	git submodule update --init
	cd evm-semantics \
		&& make k-deps tangle-deps -B \
		&& make build-java -B

deps-npm:
	npm install

SHELL = bash
dirs = {bin,libexec}
prefix ?= /usr/local

dirs:; mkdir -p $(prefix)/$(dirs)
files = $(shell ls -d $(dirs)/*)
link: uninstall dirs; npm i; for x in $(files); do \
	ln -s `pwd`/$$x $(prefix)/$$x; done
uninstall:; rm -rf $(addprefix $(prefix)/,$(files))

clean:
	rm -fdR out/*
