# LazyVim Config - Keybinds

The following document contains references for default and custom LazyVim
keybinds, to assist with learning and migration. A LazyVim custom keybind
reference is available [here](https://www.lazyvim.org/keymaps).

## Migrated/Changed Keybinds

These binds are different on this LazyVim setup vs. previous 'pure' nvim setup.
Some may have been added in this config specifically.

- Clear search highlight: `<esc>` - insert & normal
- View line diagnostics: `<leader>cd`
- LuaSnip prev/next placeholder: `<C-h>` / `<C-l>`

## New Keybinds

- Telescope - show hidden files: `<M-h>`
- Telescope - show git files: `<M-i>`
- Telescope - show cwd files only: `<M-c>`
- Noice - dismiss all notification popups: `<leader>un` / `<leader>snd`
- vim-illuminate - move to prev/next occurrence of symbol under cursor: `[[` / `]]`
- autopairs - insert mode, insert closing pair: `<M-e>`
  - Insert mode: enter opening char (e.g. `"`, `(`), then `<M-e>` and select location for closing char
- regexplainer - explain regex under cursor: `gR`
- mini.surround surround-based keybinds: `gz*`
- edgy.nvim - next/previous window: `[w` / `]w`
