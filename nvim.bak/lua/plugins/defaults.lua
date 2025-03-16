-- modifications to LazyVim default specs here
-- local python_line_length = "120" -- used by ruff_lsp & null-ls python sources

return {
  -- ==VISUAL== --
  -- disable animated indent scope context highlights
  { "echasnovski/mini.indentscope", enabled = false },
  -- add visual customizations to indent-blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      scope = {
        enabled = true,
        show_start = false,
      },
    },
  },
  -- remove lualine pointed arrow separators in favor of vertical lines
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        component_separators = { left = " ", right = " " },
        section_separators = { left = "", right = "" },
      },
      sections = {
        -- replacing right-most section (current time) with file info
        lualine_y = {
          "encoding",
          "filesize",
          "filetype",
        },
        lualine_z = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
      },
    },
  },
  -- auto install additional treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "toml",
      },
      -- indent = {
      --   disable = {
      --     "python", -- use vim-python-pep8-indent for indents instead
      --   },
      -- },
    },
  },
  -- move neo-tree to open on right
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   opts = {
  --     window = {
  --       position = "right",
  --     },
  --   },
  -- },
  -- use classic cmdline instead of popup window
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        view = "cmdline", -- or cmdline_popup
      },
      presets = {
        command_palette = false, -- floating tab completion w/ cmdline_popup
      },
    },
  },
  -- add additional Telescope keybinds
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- stylua: ignore
      {
        -- Telescope lsp document symbols keybind
        -- example: can be used with marksman LSP to search & jump to .md file heading
        "<leader>sL",
        function()
          require("telescope.builtin").lsp_document_symbols()
        end,
        desc = "Search All Symbols",
      },
      {
        -- Telescope lsp references under cursor keybind
        -- See all references to lsp symbol under cursor
        "<leader>sl",
        function()
          require("telescope.builtin").lsp_references()
        end,
        desc = "Symbol Under Cursor References",
      },
    },
  },
  -- ==LSP/CODE== --
  -- modify LSP config
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      keys[#keys + 1] = { "gl", vim.diagnostic.open_float, desc = "Line Diagnostics" }
    end,
    opts = {
      capabilities = {
        textDocument = {
          foldingRange = { -- capabilities for nvim-ufo
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      },
      servers = {
        -- pylsp = { -- after server installation run :PylspInstall pylsp-rope
        --   settings = {
        --     pylsp = {
        --       plugins = {
        --         autopep8 = { enabled = false },
        --         mccabe = { enabled = false },
        --         pycodestyle = { enabled = false },
        --         pyflakes = { enabled = false },
        --         yapf = { enabled = false },
        --       },
        --     },
        --   },
        -- },
        -- pyright = {}, -- included to ensure autoinstall
        pyright = { -- auto install pyright with Mason
          settings = {
            pyright = {
              autoImportCompletion = true,
            },
            python = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly", -- "workspace"
                useLibraryCodeForTypes = true,
                -- typeCheckingMode = "basic", -- default is "standard"
              },
            },
          },
        },
        ruff_lsp = {
          -- this can instead be set globally in ~/.config/ruff/pyproject.toml
          -- doing so allows local project configs to override this setting
          --   init_options = {
          --     settings = {
          --       args = { "--line-length", python_line_length },
          --     },
          --   },
        },
      },
      diagnostics = {
        underline = true,
        -- virtual_text = false,
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      opts.completion.keyword_length = 2
    end,
  },
  -- disable mini.pairs in faovr of nvim-autopairs
  { "echasnovski/mini.pairs", enabled = false },
  -- add additional snippets from nvim/snippets directory
  {
    "L3MON4D3/LuaSnip",
    config = function()
      -- load snipmate *.snipppets files
      -- require("luasnip.loaders.from_snipmate").lazy_load()
      -- path relative to $MYVIMRC
      require("luasnip.loaders.from_vscode").lazy_load({ paths = "./my_snippets" })
    end,
    -- stylua: ignore
    keys = {
      {
        "<C-l>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<C-l>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<C-h>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },
  -- disable f/F/t/T motions for flash.nvim in favor of default motions
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          enabled = false,
          jump_labels = false,
        },
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(buffer)
        -- Reference from https://github.com/LazyVim/LazyVim/blob/f9dadc11b39fb0b027473caaab2200b35c9f0c8b/lua/lazyvim/plugins/editor.lua#L332C7-L353C1
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line() end, "Blame Line")  -- Changed keybind
        map("n", "<leader>ghB", function() gs.blame_line({ full = true }) end, "Blame Line With Preview")  -- Added keybind
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },
}
