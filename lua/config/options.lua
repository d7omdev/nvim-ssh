-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

vim.g.lazygit_config = true
vim.g.node_host_prog = "$HOME/.bun/bin/neovim-node-host"

opt.laststatus = 3

-- Make cursor blink
opt.guicursor = {
  "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50",
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
  "sm:block-blinkwait175-blinkoff150-blinkon175",
}
opt.linebreak = true
-- Set tab width
opt.expandtab = false
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true

-- Disable highlighting if file is over 10 MB
vim.api.nvim_command('autocmd BufReadPost * if getfsize(expand("%:p")) > 10000 * 1024 | TSBufDisable highlight | endif')

vim.cmd([[cab Wq wq]])

-- Disable virtual text
vim.diagnostic.config({ virtual_text = false })

vim.loader.enable()

-- Add this to your init.lua

-- OSC52 implementation for SSH clipboard
local function osc52_copy(lines)
  -- Join the lines with newlines
  local text = table.concat(lines, "\n")

  -- Convert to base64
  local output = vim.fn.system("base64", text)
  -- Remove trailing newlines from base64 output
  output = string.gsub(output, "\n", "")

  -- Create the OSC52 sequence
  local osc = string.format("\x1b]52;c;%s\x07", output)

  -- Send to terminal
  vim.fn.chansend(vim.v.stderr, osc)
  return 0
end

-- Set up clipboard provider
vim.g.clipboard = {
  name = "OSC52",
  copy = {
    ["+"] = osc52_copy,
    ["*"] = osc52_copy,
  },
  paste = {
    ["+"] = function()
      return { "" }
    end,
    ["*"] = function()
      return { "" }
    end,
  },
}

-- Enable system clipboard integration
vim.opt.clipboard = "unnamedplus"
