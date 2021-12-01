all: grammar.js
	./node_modules/.bin/tree-sitter generate
	node-gyp configure
	node-gyp build
	./node_modules/.bin/tree-sitter test

