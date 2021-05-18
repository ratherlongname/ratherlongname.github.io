.PHONY: build dev clean help
.DEFAULT: build

help:
	@echo "make <target>"
	@echo "available targets:"
	@echo "\t build \t Build deployable website in docs/"
	@echo "\t dev \t Make css file with all tailwind rules in src/"
	@echo "\t help \t Show this help"
	@echo "\t clean \t Remove docs"

build: docs/index.html docs/styles.css

docs/index.html: src/index.html | docs
	cp $^ $@

docs/styles.css: tailwind.config.js docs/index.html | docs
	NODE_ENV=production npx tailwindcss-cli@latest build -o $@

docs:
	mkdir -p docs

dev: src/styles.css

src/styles.css:
	npx tailwindcss-cli@latest build -o $@

clean:
	-rm -rf docs