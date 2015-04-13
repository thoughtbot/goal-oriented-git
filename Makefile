SRCS=$(wildcard src/*.md)
CHAPTERS=$(patsubst src/%,book/%,$(SRCS))
PAPERBACK=docker run --volume $(PWD):/book thoughtbot/paperback

.PHONY: clean stats submodules

build: submodules $(CHAPTERS)
	$(PAPERBACK) build

stats: submodules $(CHAPTERS)
	$(PAPERBACK) stats

book/%.md: src/%.md bin/scriptrunner lib/script_runner
	bin/scriptrunner $< > $@

submodules: .gitmodules
	git submodule init
	git submodule update

release: build
	rm -rf release
	cp -R build/goal-oriented-git release

clean:
	rm -rf build
	rm $(CHAPTERS)
	git submodule deinit -f .
