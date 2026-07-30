return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      on_colors = function(colors)
        -- 让窗口边线更清晰但不过分引人注目
        colors.border = colors.dark3
        -- 让注释变亮一点
        colors.comment = colors.dark5
      end,
    },
  },
  { "folke/flash.nvim", enabled = false },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "expert",
      },
    },
  },
  { import = "lazyvim.plugins.extras.lang.typescript" },
}
