local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()

parser_config.hcl.used_by = {'hcl', 'tf'}

require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'dockerfile',
    'go',
    'gomod',
    'hcl',
    'html',
    'json',
    'lua',
    'python',
    'svelte',
    'typescript',
    'vue',
    'yaml',
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = false,
  },
}
