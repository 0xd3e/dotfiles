local group = vim.api.nvim_create_augroup('FtTempl', { clear = true })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = group,
  pattern = '*.templ',
  callback = function()
    vim.bo.filetype = 'templ'
  end,
})
