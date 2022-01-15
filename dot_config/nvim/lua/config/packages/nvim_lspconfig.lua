local function capabilities()
  return require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
end

local nvim_lspconfig = {}

function nvim_lspconfig.setup()
  local capabilities = capabilities()

  require('lspconfig')['gopls'].setup {
    capabilities = capabilities,
  }
  require('lspconfig')['pylsp'].setup {
    capabilities = capabilities,
  }
  require('lspconfig')['tsserver'].setup {
    capabilities = capabilities,
  }
  require('lspconfig')['vuels'].setup {
    capabilities = capabilities,
  }
end

return nvim_lspconfig
