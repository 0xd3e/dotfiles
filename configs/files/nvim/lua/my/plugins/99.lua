return {
  'ThePrimeagen/99',
  config = function()
    local _99 = require('99')

    _99.setup({
      provider = _99.Providers.ClaudeCodeProvider,
      model = 'claude-sonnet-4-6',
      md_files = {
        'AGENT.md',
        'CLAUDE.md',
      },
    })

    vim.keymap.set('n', '<leader>9f', function()
      _99.fill_in_function()
    end)

    vim.keymap.set('v', '<leader>9v', function()
      _99.visual()
    end)

    vim.keymap.set('v', '<leader>9s', function()
      _99.stop_all_requests()
    end)

    vim.keymap.set('n', '<leader>9m', function()
      _99.extensions.telescope.select_model()
    end)
  end,
}
