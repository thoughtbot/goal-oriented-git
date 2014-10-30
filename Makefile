SRCS=$(wildcard src/*.md)
CHAPTERS=$(patsubst src/%,book/%,$(SRCS))

.PHONY: clean stats

build: $(CHAPTERS) .bundle
	bin/stubs/paperback build

stats: $(CHAPTERS) .bundle
	bin/stubs/paperback stats

.bundle: Gemfile
	bundle --path .bundle --binstubs bin/stubs

book/%.md: src/%.md bin/scriptrunner lib/script_runner
	bin/scriptrunner $< > $@

clean:
	rm -rf build
	rm $(CHAPTERS)
