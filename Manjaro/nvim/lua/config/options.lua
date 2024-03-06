-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
local cmd = vim.cmd

-- ==behavior== --
opt.clipboard = "" -- do NOT use system clipboard (unnamedplus), the default LazyVim behavior

vim.g.python3_host_prog = "~/.py3vim/bin/python3"
-- disable format on save (works w/ LSP, format functions, etc. in LazyVim)
vim.g.autoformat = false

-- folding
-- opt.foldenable = false -- disable folding entirely
-- opt.foldmethod = "marker" -- use {{{ / }}} to mark folds
-- opt.foldlevelstart = 99 -- start buffer with all folds open (can be overriden by modeline etc.)
opt.foldcolumn = "0" -- fold column for nvim-ufo, set to "1" to see fold buttons & guides
opt.foldlevel = 99 -- set all folds open by default

-- ==visual== --
opt.linebreak = true -- wrap on word boundaries
opt.colorcolumn = { "81", "89", "121" } -- vertical marker at columns 81, 89, 121
-- opt.signcolumn = "yes:2" -- display git gutter & diagnostics in separate columns, always visible
