return {
  'EdenEast/nightfox.nvim',
  dependencies = {
    'f-person/auto-dark-mode.nvim',
  },
  config = function()
    require('nightfox').setup({
      groups = {
        dayfox = {
          CursorLine = { bg = 'palette.bg0' },
        },
      },
    })

    require('auto-dark-mode').setup({
      set_dark_mode = function()
        vim.o.background = 'dark'
        vim.cmd.colorscheme('nightfox')
      end,
      set_light_mode = function()
        vim.o.background = 'light'
        vim.cmd.colorscheme('dayfox')
      end,
    })
  end,
}
