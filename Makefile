.PHONY: build dev clean help
.DEFAULT: help

help:
	@echo "make <target>"
	@echo "available targets:"
	@echo "\t build \t Build deployable website in dist/"
	@echo "\t dev \t Make css file with all tailwind rules in src/"
	@echo "\t help \t Show this help"
	@echo "\t clean \t Remove dist"

deploy: build
	git subtree push --prefix dist origin gh-pages

build: dist/index.html dist/styles.css

dist/index.html: src/index.html | dist
	cp $^ $@

dist/styles.css: tailwind.config.js dist/index.html | dist
	NODE_ENV=production npx tailwindcss-cli@latest build -o $@

dist:
	mkdir -p dist

dev: src/styles.css

src/styles.css:
	npx tailwindcss-cli@latest build -o $@

clean:
	-rm -rf dist