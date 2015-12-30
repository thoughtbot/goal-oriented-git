SRCS=$(wildcard src/*.md)
CHAPTERS=$(patsubst src/%,book/%,$(SRCS))
PAPERBACK=docker run --volume $(PWD):/book thoughtbot/paperback

.PHONY: clean stats

build: $(CHAPTERS)
	$(PAPERBACK) build

stats: $(CHAPTERS)
	$(PAPERBACK) stats

book/%.md: src/%.md bin/scriptrunner lib/script_runner
	bin/scriptrunner $< > $@

release: build
	rm -rf release
	cp -R build/goal-oriented-git release

clean:
	rm -rf build
	rm $(CHAPTERS)
