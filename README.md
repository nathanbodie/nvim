# nvim config

Minimal Neovim config. Lazy for plugins, Mason for LSPs, mini.pick for fuzzy finding.

## plugins

- **vague.nvim** — colorscheme
- **mason** — LSP installer
- **blink.cmp** — completion
- **mini.pick** — fuzzy finder (files, buffers, grep, help)
- **mini.pairs** — auto pairs
- **oil.nvim** — file explorer
- **nvim-treesitter** — syntax highlighting
- **which-key** — keybind hints

## keymaps

Leader is `<space>`.

| key | action |
|-----|--------|
| `<leader>f` | find files |
| `<leader>r` | find buffers |
| `<leader>g` | live grep |
| `<leader>h` | help |
| `<leader>o` | oil (file explorer) |
| `<leader>e` | diagnostic float |
| `<leader>lf` | LSP format |
| `<leader>y` | yank to system clipboard |
| `<leader>d` | delete to system clipboard |
| `<leader>v` | open init.lua |
| `<leader>z` | open .zshrc |
