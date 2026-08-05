vim.pack.add({
  { src = "https://codeberg.org/evergarden/nvim.git", name = "evergarden" },
  { src = "https://github.com/nvim-mini/mini.pick" },
  { src = "https://github.com/nvim-mini/mini.pairs" },
  { src = "https://github.com/nvim-mini/mini.statusline" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/Saghen/blink.cmp", version = "1.7.0" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" }
})

require("evergarden").setup({
  theme = {
    variant = "fall", -- "winter"|"fall"|"spring"|"summer"
    accent = "green",
  },
  editor = {
    transparent_background = false,
    sign = { color = "none" },
    float = {
      color = "mantle",
      solid_border = false,
    },
    completion = {
      color = "surface0",
    },
  },
})
vim.cmd.colorscheme("evergarden")

require("mini.pick").setup()
require("mini.pairs").setup()
require("mini.statusline").setup({
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local git = MiniStatusline.section_git({ trunc_width = 75, icon = vim.fn.nr2char(0xe725) .. " " })
      local filetype = vim.bo.filetype ~= "" and vim.bo.filetype or "no ft"
      local location = vim.fn.nr2char(0xf0224) .. " " .. vim.fn.line("$") -- total line count
      local cwd = vim.fn.nr2char(0xf07b) .. " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

      return MiniStatusline.combine_groups({
        { hl = mode_hl, strings = { mode } },
        "%<", -- truncation point
        { hl = "MiniStatuslineFilename", strings = { cwd } },
        { hl = "MiniStatuslineDevinfo", strings = { git } },
        "%=", -- right align everything after this
        { hl = "MiniStatuslineFileinfo", strings = { filetype } },
        { hl = mode_hl, strings = { location } },
      })
    end,
  },
})
require("oil").setup()

require("which-key").setup()
vim.keymap.set("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })

require("blink.cmp").setup({
  keymap = { preset = "default" },
  appearance = { nerd_font_variant = "mono" },
  completion = { documentation = { auto_show = false } },
  sources = { default = { "lsp", "path", "snippets", "buffer" } },
  fuzzy = { implementation = "lua" },
})

require("gitsigns").setup()
