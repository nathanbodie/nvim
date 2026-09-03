require("plugins")
require("lsp")

-- vim options
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.termguicolors = true
vim.o.clipboard = "unnamedplus"
vim.o.wrap = false
vim.o.winborder = "single"

-- keymaps
vim.g.mapleader = ' '
local map = vim.keymap.set

-- system clipboard
map({ 'n', 'v' }, '<leader>y', '"+y')
map({ 'n', 'v' }, '<leader>d', '"+d')

map('n', '<leader>lf', function()
  require('conform').format({ lsp_format = 'fallback' })
end)
map('n', '<leader>f', '<Cmd>Pick files<CR>')
map('n', '<leader>r', '<Cmd>Pick buffers<CR>')
map('n', '<leader>/', '<Cmd>Pick grep_live<CR>')
map('n', '<leader>g', '<Cmd>Pick git_hunks<CR>')
map('n', '<leader>mh', '<Cmd>Pick help<CR>')
map('n', '<leader>mk', '<Cmd>Pick keymaps<CR>')
map('n', '<leader>o', '<Cmd>Oil<CR>')
map('n', '<leader>e', '<Cmd>lua vim.diagnostic.open_float()<CR>')

vim.cmd.colorscheme("evergarden")
