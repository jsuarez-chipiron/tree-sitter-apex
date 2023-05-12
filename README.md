# tree-sitter-apex

Apex grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).

Based on the official Java grammar [https://github.com/tree-sitter/tree-sitter-java](https://github.com/tree-sitter/tree-sitter-java).

## compile

To compile the grammar just clone the repo and run the following commands

```sh
npm install
./node_modules/.bin/tree-sitter generate
node-gyp configure
node-gyp build
```
## install and use

### command line util

Once compiled it can be tested with the command line utility.

```sh
tree-sitter parse test/Sample.cls
```

### use in neovim

To use the parser in neovim you will require the neovim plugin [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

In your nvim config you can set the following instructions. Change the url to point to the local path where the repo has been cloned.

```lua
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.apex = {
  install_info = {
    url = "~/Tech/treesitter/tree-sitter-apex", -- local path or git repo
    files = {"src/parser.c"}
  },
  filetype = "apexcode", -- if filetype does not agrees with parser name
}
```

And then install it with:

```
TSInstall apex
```

### use in rust

In a rust project add the tree-sitter dependency

```sh
cargo add tree-sitter
```

Then add the dependency to the cc compiler in your Cargo.toml

```toml
[build-dependencies]
cc = "1.0"
```

And finally create a build.rs file that will compile the tree-sitter lib

```rust
extern crate cc;

use std::path::PathBuf;

fn main()
{
    let dir: PathBuf = [<point to the path where the tree-sitter-apex repo has been cloned in your local machine> ]
    .into_iter()
    .collect();
     
    cc::Build::new()
        .include(&dir)
        .file(dir.join("parser.c"))
        .compile("tree-sitter-apex");
}

```

And for use, in your main.rs you can add this:

```rust
use tree_sitter::{Language, Parser};
...
let language = unsafe { tree_sitter_apex() };
let mut parser = Parser::new();
parser.set_language(language).unwrap();

```
### use in lua

Once is installed the grammar in the neovim tree-sitter plugin.

```lua
local ts_utils = require"nvim-treesitter.ts_utils"

local p_bufnr = vim.api.nvim_get_current_buf()

local parser = vim.treesitter.get_parser(p_bufnr, 'apex')
local root = parser:parse()[1]:root()
```

### use in python

Install the python bindings for tree-sitter

And compile the library to be used for the python program.

```python
from tree_sitter import Language, Parser

Language.build_library(
  'build/tree-sitter-apex.so',
  [
    '<point to the path where the tree-sitter-apex repo has been cloned in your local machine>'
  ]
)
```

And for use

```python
APEX_LANGUAGE = Language('build/tree-sitter-apex.so', 'apex')

parser = Parser()
parser.set_language(APEX_LANGUAGE)
```

## functionalities

All the functionalities implemented can be checked in the src/Sample.cls file

My personal suggestion is to configure neovim tree_sitter plugin and then use the tree_sitter playground. [https://github.com/nvim-treesitter/playground](https://github.com/nvim-treesitter/playground)

- apex specific modifiers. (global, with/without sharing)
```java    
    global with sharing class Class1
```
- apex string\_literal
```java
    System.debug('foo');
```
- query\_literal
```java    
    List<String> l = [ 
        SELECT field1, field2 
        FROM Account];
```
- dml\_statement
```java    
    public DML_examples() {
        List<String> l = [ 
            SELECT field1, field2 
            FROM Account];

        insert l;
        update l;
        delete l;
    }
```
- enhanced\_dml\_statement
```java
    public Enhanced_DML_example() {
        delete [SELECT id FROM Account];
    }
```
- null\_safe\_operator
```java
    String myString = myContact?.Account?.RecordType.Name;
```
- not\_equals\_operators
```java
    if ( 1 <> 2 ) {
        String x = 'foo';
    }
 
    if ( 1 != 2 ) {
        String x = 'foo';
    }
```
## questions/issues

Please open an issue on this repo and we'll work through it.

## contributing

There are still some parsing error. If you want to fix some of them please feel free to send a PR.
