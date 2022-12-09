# OppTogg

Toggle a word under the cursor to its 'opposite value', e.g. `True` -> `False`.

## Installation and Setup

With packer:

```lua
use({
  "al-ce/opptogg.nvim",
  config = function()
    require('opptogg').setup({
    -- config or leave empty for defaults
    })
    end
})
```

## Usage

Set the cursor over a word in OppTogg's table and execute `:OppTogg` to 
substitute its 'opposite'. The cursor remains in its current position.
Example (where `*` denotes cursor position):

```
Before            | After
------------------|--------------------
if foo == tr*ue:  | if foo == fa*lse:
```

## Configuration

This shows the default configuration. Passing a new table to `opp_table` will
override the default table completely.

No mapping is set by default. Set a mapping for `:OppTogg` on your own or set 
a string value in `mapping` to have the config do it for you.

```lua
 require('opptogg').setup({
  opp_table = {
    ["True"]  = "False",
    ["true"]  = "false",
    ["0"]     = "1",
    ["yes"]   = "no",
    ["Yes"]   = "No",
    ["foo"]   = "bar",
    ["var1"]  = "var2",
  },
  mapping = '', -- I use <leader>` since ` toggles upper/lower case.
})
```

## Known Issues

Currently, only words with characters matched by the regex `\k` can be toggled.
This excludes symbols like `+-*/=~!` and spaces.

## Acknowledgements
[cursor-word.nvim](https://github.com/xiyaowong/nvim-cursorword/blob/master/plugin/nvim-cursorword.lua) for the code to match the word under the cursor.


