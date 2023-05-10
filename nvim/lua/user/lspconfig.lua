local border_opts = { border = 'rounded' }

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  border_opts
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  border_opts
)

local map = vim.keymap.set

-- Diagnostic keymaps
-- Move to the next diagnostic
map('n', '[d', function() vim.diagnostic.goto_prev({ float = border_opts }) end)
-- Move to the previous diagnostic
map('n', ']d', function() vim.diagnostic.goto_next({ float = border_opts }) end)
-- Display diagnostic (warings/errors) at the cursor line
map('n', '<Leader>e', function() vim.diagnostic.open_float(border_opts) end)
--Display diagnostic with location list
map('n', '<Leader>dd', vim.diagnostic.setloclist)

-- LSP settings.
-- This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  -- See `:help vim.lsp.*` for documentation on any of the below functions

  nmap('<Leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<Leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  -- nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<Leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<Leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<Leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  -- Display documentation for the module/function under the cursor
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  -- Display documentation when the cursor is on the argument of the module/function
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Format the current buffer
  nmap('<LocalLeader>f', vim.lsp.buf.format, '[F]ormat current buffer with LSP')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<Leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<Leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<Leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')
end

local helpers = require('user.helpers')
local augroup = helpers.augroup
local autocmd = helpers.autocmd

augroup("LspFormat", function(group)
  autocmd("BufWritePre", {
    group = group,
    pattern = "*",
    callback = function()
      vim.lsp.buf.formatting_sync()
    end,
  })
end)

local lsp_flags = {
  debounce_text_changes = 150,
}

local servers = {
  -- sumneko_lua = {
  --   Lua = {
  --     diagnostics = {
  --       globals = { 'vim' }
  --     },
  --     workspace = {
  --       checkThirdParty = false,
  --       telemetry = { enable = false },
  --       library = {
  --         [vim.fn.expand('$VIMRUNTIME/lua')] = true,
  --         [vim.fn.stdpath('config') .. '/lua'] = true,
  --       }
  --     }
  --   }
  -- },
  elixirls = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false,
      -- languageServerOverridePath = "/Users/david/workspace/op/elixir-ls/release"
    }
  },
  rust_analyzer = {},
  yamlls = {
    yaml = {
      schemas = {
        ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.yaml"] = "openapi.yaml"
      }
    }
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
require('mason-lspconfig').setup({
  ensure_installed = vim.tbl_keys(servers)
})

require('mason-lspconfig').setup_handlers({
  function(server_name)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    require('lspconfig')[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      flags = lsp_flags,
      settings = servers[server_name],
    })
  end,
})

-- Turn on lsp status information
require('fidget').setup()
