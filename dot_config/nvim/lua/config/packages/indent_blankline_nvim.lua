local indent_blankline_nvim = {}

function indent_blankline_nvim.setup()
  require('indent_blankline').setup({
    show_current_context = true,
    buftype_exclude = {
      'help',
      'terminal',
    },
  })
end

return indent_blankline_nvim
