require('nvim-treesitter.configs').setup {
  highlight = { enable = true }
}

-- vim.cmd "set foldmethod=expr"
vim.cmd "set foldexpr=nvim_treesitter#foldexpr()"
-- vim.cmd "set foldlevel=1"
vim.wo.foldlevel = 99
vim.wo.foldmethod = "expr"
