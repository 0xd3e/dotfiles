local nvim_treesitter = {}

function nvim_treesitter.setup()
  local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

  parser_configs.python.used_by = {'bzl'}

  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'css',
      'dockerfile',
      'go',
      'gomod',
      'hcl',
      'html',
      'javascript',
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
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
  })
end

return nvim_treesitter
