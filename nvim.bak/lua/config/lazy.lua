local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    --- -- misc extras: util, ui, ... --
    { import = "lazyvim.plugins.extras.util.project" }, -- detect and switch projects
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" }, -- highlight color codes
    -- { import = "lazyvim.plugins.extras.vscode"}, -- vim.g.vscode-aware. enable only plugins with vscode=true spec, keymap changes.
    { import = "lazyvim.plugins.extras.ui.edgy" }, -- predefined window/UI positions

    --- -- python extras (debug/test, LSP, etc.) --
    { import = "lazyvim.plugins.extras.lang.python" },
    -- semantic highlighting - after install, run :UpdateRemotePlugins

    --- -- additional (not python) languages --
    { import = "lazyvim.plugins.extras.lang.json" }, -- json treesitter, SchemaStore, ...
    { import = "lazyvim.plugins.extras.lang.yaml" },
    -- { import = "lazyvim.plugins.extras.lang.docker" },
    -- { import = "lazyvim.plugins.extras.lang.go" },
    -- { import = "lazyvim.plugins.extras.lang.rust" },

    --- -- other editing --
    -- use prettier extra to autoconfigure all supported filetypes with conform.nvim
    { import = "lazyvim.plugins.extras.formatting.prettier" },

    --- -- rest of custom plugin configuration --
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "everforest", "tokyonight", "habamax" } }, -- use colors when installing missing plugin during startup
  checker = { enabled = false }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
