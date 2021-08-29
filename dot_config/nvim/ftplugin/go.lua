local helpers = require('helpers')

require 'lspconfig'.gopls.setup {}

-- Set indentation
helpers.set_indent('tabs', 4)

-- Format code on save
helpers.create_augroup({
  {'BufWritePre', '*.go', 'lua', 'vim.lsp.buf.formatting_sync()'}
}, 'gofmtonsave')
