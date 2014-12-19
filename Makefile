SRCS=$(wildcard src/*.md)
CHAPTERS=$(patsubst src/%,book/%,$(SRCS))

.PHONY: clean stats

build: $(CHAPTERS) .bundle
	bin/stubs/paperback build

stats: $(CHAPTERS) .bundle
	bin/stubs/paperback stats

.bundle: Gemfile
	bundle --path .bundle --binstubs bin/stubs

book/%.md: src/%.md bin/scriptrunner lib/script_runner examples
	bin/scriptrunner $< > $@

examples: .gitmodules
	git submodule init
	git submodule update

clean:
	rm -rf build
	rm $(CHAPTERS)
