return {
  {
    "catppuccin/nvim",
    event = "BufRead",
    name = "catppuccin",
    opts = {
      -- transparent_background = true,
    },
  },
  {
    "mvllow/modes.nvim",
    event = "BufRead",
    enabled = true,
    config = function()
      require("modes").setup({
        line_opacity = 0.15,
        set_cursorline = false,
        set_number = false,
        ignore_filetypes = { "NvimTree", "TelescopePrompt", "dashboard", "minifiles" },
      })
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "LspAttach",
    config = function()
      vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "lazy", "text" },
        callback = function()
          vim.diagnostic.config({ virtual_lines = false })
        end,
      })
      require("lsp_lines").setup()
    end,
  },
}
