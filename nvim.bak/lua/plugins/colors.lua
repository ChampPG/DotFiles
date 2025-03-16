-- colorscheme installation, confguration
local Util = require("lazyvim.util")
return {
  -- set colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
      -- colorscheme = "zenwritten",
      -- colorscheme = "catppuccin",
    },
  },
  -- colorscheme: everforest
  { "sainnhe/everforest" },
  {
    "mcchrish/zenbones.nvim",
    dependencies = {
      "rktjmp/lush.nvim",
    },
    lazy = true,
    -- stylua: ignore
    keys = { { "<leader>uC", function() Util.telescope("colorscheme", { enable_preview = true }) end, desc = "Colorscheme with preview" } },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    -- stylua: ignore
    keys = { { "<leader>uC", function() Util.telescope("colorscheme", { enable_preview = true }) end, desc = "Colorscheme with preview" } },
    -- lazy = true,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      show_end_of_buffer = false, -- ~ chars at EOB
      integrations = {
        alpha = true,
        cmp = true,
        flash = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
        },
        leap = true,
        lsp_trouble = true,
        markdown = true,
        mason = true,
        native_lsp = {
          enabled = true,
        },
        navic = {
          enabled = true,
        },
        neotree = true,
        noice = true,
        notify = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    -- stylua: ignore
    keys = { { "<leader>uC", function() Util.telescope("colorscheme", { enable_preview = true }) end, desc = "Colorscheme with preview" } },
  },
  {
    "Shatur/neovim-ayu",
    lazy = true,
    -- stylua: ignore
    keys = { { "<leader>uC", function() Util.telescope("colorscheme", { enable_preview = true }) end, desc = "Colorscheme with preview" } },
    config = function()
      require("ayu").setup({
        mirage = true,
      })
    end,
  },
}
