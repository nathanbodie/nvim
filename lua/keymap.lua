vim.g.mapleader = ' '
local map = vim.keymap.set

map('n', '<leader>R', function()
  vim.cmd('update')
  for name, _ in pairs(package.loaded) do
    if name:match('^keymap') or name:match('^plugins') or name:match('^lsp') then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
  vim.notify('config reloaded')
end)

-- system clipboard
map({ 'n', 'v' }, '<leader>y', '"+y')
map({ 'n', 'v' }, '<leader>d', '"+d')

map('n', '<leader>lf', function()
  require('conform').format({ lsp_format = 'fallback' })
end)
map('n', '<leader>f', '<Cmd>Pick files<CR>')
map('n', '<leader>r', '<Cmd>Pick buffers<CR>')
map('n', '<leader>g', '<Cmd>Pick grep_live<CR>')
map('n', '<leader>h', '<Cmd>Pick help<CR>')
map('n', '<leader>o', '<Cmd>Oil<CR>')
map('n', '<leader>e', '<Cmd>lua vim.diagnostic.open_float()<CR>')
