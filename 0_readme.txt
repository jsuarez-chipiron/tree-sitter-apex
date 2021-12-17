https://gist.github.com/Aerijo/df27228d70c633e088b0591b8857eeef

**********************************
 GENERATE GRAMMAR
**********************************

cd ~/Tech/treesitter/tree-sitter-apex
./node_modules/.bin/tree-sitter generate
node-gyp configure
node-gyp build

tree-sitter parse AbstractWorker.cls

TSUninstall apex
TSInstall apex


**********************************
 In rust
**********************************

El código está en bindings/rust/lib.rs

cargo test -- --nocapture

# la opción nocapture hace que se muestren los println! en los test

