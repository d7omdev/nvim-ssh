local autocmd = vim.api.nvim_create_autocmd

local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

autocmd({ "User" }, {
  pattern = "CodeCompanionInline*",
  group = group,
  callback = function(request)
    if request.match == "CodeCompanionInlineFinished" then
      -- Format the buffer after the inline request has completed
      require("conform").format({ bufnr = request.buf })
    end
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.cmd([[silent! %s/\s\+$//e]])
  end,
})

-- Setup filetype for .aliasesrc
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = ".aliasesrc",
  callback = function()
    vim.bo.filetype = "zsh"
  end,
})
