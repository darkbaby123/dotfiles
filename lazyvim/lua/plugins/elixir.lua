return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "expert",
      },
    },
  },
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

  -- -- Extend the existing Elixir configuration from LazyVim extras
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     -- This ensures the Elixir extras configuration is loaded
  --     extras = {
  --       { import = "lazyvim.plugins.extras.lang.elixir" },
  --     },
  --   },
  -- },

  -- Override nvim-lspconfig settings for Elixir
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       -- Disable elixirls if it was installed by mason
  --       elixirls = false,
  --       -- Configure the expert language server
  --       expert = {
  --         -- The command to run the language server
  --         -- cmd = { "expert", "lsp" },
  --         -- Define filetypes the server should handle
  --         filetypes = { "elixir", "eelixir", "heex" },
  --         -- -- Automatically start the server in projects with a mix.exs file
  --         -- root_dir = require("lspconfig.util").find_root({
  --         --   "mix.exs",
  --         --   ".git",
  --         --   "mix.lock",
  --         -- }),
  --       },
  --     },
  --   },
  -- },
  -- -- Ensure mason installs the expert binary instead of elixirls
  -- {
  --   "williamboman/mason.nvim",
  --   opts = {
  --     ensure_installed = {
  --       "expert", -- Ensure mason tries to install 'expert'
  --     },
  --   },
  -- },
}
