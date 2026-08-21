-- Advertise blink.cmp's completion capabilities (resolve + additionalTextEdits)
-- to every server so auto-import completion items work.
vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

-- Lua
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      workspace = { checkThirdParty = false },
    },
  },
})

-- TypeScript / JavaScript
vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_markers = { 'package.json', 'tsconfig.json', '.git' },
  -- Fallback TS install for projects without a local `typescript` dependency.
  -- The global `typescript` is 7.x (native port) and ships no tsserver.js.
  init_options = {
    tsserver = {
      path = vim.fn.expand('~/.local/share/ts5/node_modules/typescript/lib/tsserver.js'),
    },
  },
})

-- Rust
vim.lsp.config('rust_analyzer', {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', '.git' },
  settings = {
    ['rust-analyzer'] = {
      cargo = { allFeatures = true },
      checkOnSave = { command = 'clippy' },
    },
  },
})

-- Python
vim.lsp.config('basedpyright', {
  cmd = { 'basedpyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', 'requirements.txt', '.git' },
})

-- Odin
vim.lsp.config('ols', {
  cmd = { 'ols' },
  filetypes = { 'odin' },
  root_markers = { 'ols.json', '.git' },
})

-- C / C++
vim.lsp.config('clangd', {
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  root_markers = { 'compile_commands.json', 'compile_flags.txt', '.git' },
})

-- Nix
vim.lsp.config('nixd', {
  cmd = { 'nixd' },
  filetypes = { 'nix' },
  root_markers = { 'flake.nix', '.git' },
})

vim.lsp.enable({
  'lua_ls',
  'ts_ls',
  'rust_analyzer',
  'basedpyright',
  'ols',
  'clangd',
  'nixd',
})

-- Re-run LSP attach for open buffers after direnv updates PATH,
-- so servers from a flake dev shell attach without :e
vim.api.nvim_create_autocmd('User', {
  pattern = 'DirenvLoaded',
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == '' then
        local ft = vim.bo[buf].filetype
        if ft ~= '' then
          -- Make `buf` the current buffer so ftplugin code that operates on
          -- buffer 0 (e.g. runtime markdown ftplugin's `vim.treesitter.start()`)
          -- acts on the right buffer, and scope by `pattern` so only this
          -- filetype's autocmds fire (never load markdown ftplugin on a nix buf).
          vim.api.nvim_buf_call(buf, function()
            vim.api.nvim_exec_autocmds('FileType', { pattern = ft, modeline = false })
          end)
        end
      end
    end
  end,
})
