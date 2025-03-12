return {
  {
    "lambdalisue/vim-suda",
    event = "VeryLazy",
    config = function()
      vim.g.suda_smart_edit = 1
      -- Expand 'ss' into 'SudaWrite' in the command line
      vim.cmd([[cab ss SudaWrite<CR>]])
    end,
  },
  { "nvchad/volt", lazy = true },
  { "nvchad/minty", lazy = true },
  {
    "nvchad/ui",
    config = function()
      require("nvchad")
    end,
  },
  {
    "nvchad/base46",
    priority = 1000,
    lazy = false,
    build = function()
      require("base46").load_all_highlights()
    end,
  },
  {
    "bbjornstad/pretty-fold.nvim",
    event = "BufRead",
    config = function()
      require("pretty-fold").setup({
        keep_indentation = true,
        fill_char = "",
        sections = {
          left = {
            "+",
            function()
              return string.rep("-", vim.v.foldlevel)
            end,
            " ",
            "number_of_folded_lines",
            ":",
            "content",
          },
        },
      })
    end,
  },
  {
    "Aasim-A/scrollEOF.nvim",
    event = "BufRead",
    config = function()
      require("scrollEOF").setup({
        disabled_filetypes = { "minifiles" },
      })
    end,
  },
  {
    "chrisgrieser/nvim-rip-substitute",
    event = "BufRead",
    cmd = "RipSubstitute",
    keys = {
      {
        "<leader>fs",
        function()
          require("rip-substitute").sub()
        end,
        mode = { "n", "x" },
        desc = " rip substitute",
      },
    },
  },
  {
    "aaronik/treewalker.nvim",
    event = "BufRead",
    opts = {
      highlight = true,
      highlight_duration = 250,
      highlight_group = "CursorLine",
    },
  },
  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    config = function()
      require("quicker").setup()
    end,
  },
  {
    "echasnovski/mini.diff",
    version = "*",
    config = function()
      require("mini.diff").setup({
        -- Options for how hunks are visualized
        view = {
          -- Visualization style. Possible values are 'sign' and 'number'.
          -- Default: 'number' if line numbers are enabled, 'sign' otherwise.
          style = vim.go.number and "number" or "sign",
          -- Signs used for hunks with 'sign' view
          signs = { add = "▒", change = "▒", delete = "▒" },
          -- Priority of used visualization extmarks
          priority = 199,
        },
      })
    end,
  },
}
