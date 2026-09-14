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

vim.diagnostic.config({
  virtual_text = {
    current_line = true,
    source = "if_many",
    prefix = "●",
    spacing = 2,
  },
})

-- keymaps
vim.g.mapleader = ' '
local map = vim.keymap.set

-- system clipboard
map({ 'n', 'v' }, '<leader>y', '"+y')
map({ 'n', 'v' }, '<leader>d', '"+d')
map('n', '<leader>f', '<Cmd>Pick files<CR>')
map('n', '<leader>r', '<Cmd>Pick buffers<CR>')
map('n', '<leader>/', '<Cmd>Pick grep_live<CR>')
map('n', '<leader>gu', '<Cmd>Pick git_hunks<CR>')
map('n', '<leader>ga', '<Cmd>Gitsigns stage_hunk<CR>', { desc = 'Stage/unstage Git hunk' })
map('v', '<leader>ga', ':Gitsigns stage_hunk<CR>', { desc = 'Stage/unstage selected Git hunk' })
map('n', '<leader>gr', '<Cmd>Gitsigns reset_hunk<CR>', { desc = 'Reset Git hunk' })
map('v', '<leader>gr', ':Gitsigns reset_hunk<CR>', { desc = 'Reset selected Git hunk' })
map('n', '<leader>gs', function()
  MiniExtra.pickers.git_hunks({
    scope = 'staged',
  })
end)
map('n', '<leader>gq', function()
  require('gitsigns').setqflist('all')
end, { desc = 'All Git hunks in quickfix' })
map('n', '<leader>mh', '<Cmd>Pick help<CR>')
map('n', '<leader>mk', '<Cmd>Pick keymaps<CR>')
map('n', '<leader>mt', function()
  MiniExtra.pickers.colorschemes()
end, { desc = 'Pick colorscheme' })
map('n', '<leader>o', '<Cmd>Oil<CR>')
map('n', '<leader>lf', function()
  require('conform').format({ lsp_format = 'fallback' })
end)
map('n', '<leader>ly', function()
  local line = vim.api.nvim_win_get_cursor(0)[1] - 1
  local diagnostics = vim.diagnostic.get(0, { lnum = line })

  if #diagnostics == 0 then
    vim.notify('No diagnostics on this line')
    return
  end

  local messages = vim.tbl_map(function(d)
    return d.message
  end, diagnostics)

  vim.fn.setreg('+', table.concat(messages, '\n'))
  vim.notify('Diagnostic copied to clipboard')
end)
map('n', '<leader>ld', '<Cmd>Trouble diagnostics toggle<CR>', { desc = 'All diagnostics' })
map('n', '<leader>lD', '<Cmd>Trouble diagnostics toggle filter.buf=0<CR>', { desc = 'Buffer diagnostics' })
map('n', '<leader>lq', '<Cmd>Trouble qflist toggle<CR>', { desc = 'Quickfix list' })
map('n', 'gd', vim.lsp.buf.definition)

-- markdown preview
map('n', '<leader>mp', '<Cmd>Markview splitToggle<CR>')
map('n', '<leader>mi', '<Cmd>Markview Toggle<CR>')

vim.cmd.colorscheme("koda-dark")
