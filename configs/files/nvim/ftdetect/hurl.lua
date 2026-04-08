local group = vim.api.nvim_create_augroup('FtHurl', { clear = true })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = group,
  pattern = '*.hurl',
  callback = function()
    vim.bo.filetype = 'hurl'
  end,
})
