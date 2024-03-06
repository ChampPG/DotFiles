-- movement and navigation related plugins (non-defaults)
return {
  -- ==MOVEMENT/NAVIGATION== --
  -- tab out of quotes, brackets, etc.
  {
    "abecodes/tabout.nvim",
    opts = {
      tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
      backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
      act_as_tab = true, -- shift content if tab out is not possible
      act_as_shift_tab = true, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <s-tab>)
      enable_backwards = true, -- well ...
      completion = false, -- if the tabkey is used in a completion pum
      ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
    },
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "L3MON4D3/LuaSnip",
      "hrsh7th/nvim-cmp",
    },
  },
}
