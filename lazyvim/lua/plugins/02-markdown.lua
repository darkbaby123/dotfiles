return {
  { import = "lazyvim.plugins.extras.lang.markdown" },
  {
    "Kicamon/markdown-table-mode.nvim",
    config = function()
      require("markdown-table-mode").setup()
    end,
  },
}
