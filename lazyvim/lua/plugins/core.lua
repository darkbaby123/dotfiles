return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      on_colors = function(colors)
        -- 让窗口边线更清晰但不过分引人注目
        colors.border = colors.dark3
        -- 让注释变亮一点
        colors.comment = colors.dark5
      end,
    },
  },
}
