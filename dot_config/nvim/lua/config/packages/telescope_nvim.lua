local telescope_nvim = {}

function telescope_nvim.setup()
  require('telescope').setup({
    defaults = {
      file_ignore_patterns = {
        'node_modules',
      },
    }
  })

  require('telescope').load_extension('fzf')
end

return telescope_nvim
