-- install plugins
vim.pack.add({
  -- theme
  { src = "https://codeberg.org/evergarden/nvim.git", name = "evergarden" },
  -- file manager
  "https://github.com/stevearc/oil.nvim",
  -- mini
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/nvim-mini/mini.align",
  "https://github.com/nvim-mini/mini.pairs",
  "https://github.com/nvim-mini/mini.surround",
  "https://github.com/nvim-mini/mini.extra",
  "https://github.com/nvim-mini/mini.pick",
  "https://github.com/nvim-mini/mini.statusline",
  -- snippets
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/rafamadriz/friendly-snippets",
  -- git
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/pwntester/octo.nvim",
  "https://github.com/sindrets/diffview.nvim",
  -- completion
  { src = "https://github.com/saghen/blink.cmp",      version = "v1.10.2" },
  -- misc
  "https://github.com/folke/which-key.nvim",
  "https://github.com/direnv/direnv.vim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/stevearc/conform.nvim",
})

-- configure
require('evergarden').setup({
  theme = {
    variant = 'fall', -- 'winter'|'fall'|'spring'|'summer'
    accent = 'green',
  },
  editor = {
    transparent_background = false,
    sign = { color = 'none' },
    float = {
      color = 'mantle',
      solid_border = false,
    },
    completion = {
      color = 'surface0',
    },
  },
})
require("oil").setup()

-- mini
require("mini.icons").setup() -- doing this first since some other plugins look for it
MiniIcons.mock_nvim_web_devicons()
require("mini.align").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.extra").setup()
require("mini.pick").setup()
require("mini.statusline").setup()

-- snippets
require("luasnip").setup()
require("luasnip.loaders.from_vscode").lazy_load() -- pulls in friendly-snippets

-- git
require("gitsigns").setup()
require("octo").setup({ -- needs gh cli authenticated
  picker = "default",
})
require("diffview").setup()

require("blink.cmp").setup({
  keymap = { preset = "default" },
  appearance = { nerd_font_variant = "mono" },
  completion = {
    documentation = { auto_show = true },
  },
  signature = { enabled = true },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  snippets = { preset = "luasnip" },
})

-- misc
require("which-key").setup()
require("conform").setup({
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})
