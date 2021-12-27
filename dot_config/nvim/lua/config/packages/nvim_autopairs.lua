local nvim_autopairs = {}

function nvim_autopairs.setup()
  require('nvim-autopairs').setup({
    check_ts = true,
    disable_filetype = {
      'TelescopePrompt',
    },
  })
end

return nvim_autopairs
