require('plugins')
require('robin.lsp')
require('robin.lualine')
require('robin.telescope')
require('robin.settings')
require('robin.treesitter')
require('robin.completion')
-- require('robin.spaceline')
require('robin.nvim-autopairs')
require('robin.diffview')

-- basic settings

local cmd = vim.cmd
local g = vim.g

g.mapleader = " "

cmd "syntax enable"
cmd "syntax on"
