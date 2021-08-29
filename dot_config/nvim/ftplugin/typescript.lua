local helpers = require('helpers')

require 'lspconfig'.tsserver.setup {}

-- Set indentation
helpers.set_indent('tabs', 4)
