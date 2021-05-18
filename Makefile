.PHONY: build dev clean help
.DEFAULT: help

SRC_PNG_FILES = $(wildcard src/*.png)
DIST_PNG_FILES = $(SRC_PNG_FILES:src=dist)

help:
	@echo "make <target>"
	@echo "available targets:"
	@echo "\t build \t Build deployable website in dist/"
	@echo "\t dev \t Make css file with all tailwind rules in src/"
	@echo "\t help \t Show this help"
	@echo "\t clean \t Remove dist"

deploy: build
	git subtree push --prefix dist origin gh-pages

build: dist/index.html dist/styles.css dist/site.webmanifest dist/favicon.ico dist/*.png

dist/index.html: src/index.html | dist
	cp $^ $@

dist/styles.css: tailwind.config.js dist/index.html | dist
	NODE_ENV=production npx tailwindcss-cli@latest build -o $@

dist/site.webmanifest: src/site.webmanifest | dist
	cp $^ $@

dist/favicon.ico: src/favicon.ico | dist
	cp $^ $@

dist/%.png: src/%.png | dist
	cp $^ dist

dist:
	mkdir -p dist

dev: src/styles.css

src/styles.css:
	npx tailwindcss-cli@latest build -o $@

clean:
	-rm -rf dist
