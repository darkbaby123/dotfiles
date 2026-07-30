return {
  { import = "lazyvim.plugins.extras.lang.elixir" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- 禁用旧的 elixirls，防止冲突
        elixirls = { enabled = false },
        -- 配置新的 expert LSP 服务器
        expert = {},
      },
    },
  },
}
