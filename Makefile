SRCS=$(wildcard src/*.md)
CHAPTERS=$(patsubst src/%,book/%,$(SRCS))

.PHONY: clean stats submodules

build: submodules $(CHAPTERS) .bundle
	bin/stubs/paperback build

stats: submodules $(CHAPTERS) .bundle
	bin/stubs/paperback stats

.bundle: Gemfile
	bundle --path .bundle --binstubs bin/stubs

book/%.md: src/%.md bin/scriptrunner lib/script_runner
	bin/scriptrunner $< > $@

submodules: .gitmodules
	git submodule init
	git submodule update

clean:
	rm -rf build
	rm $(CHAPTERS)
	git submodule deinit -f .
