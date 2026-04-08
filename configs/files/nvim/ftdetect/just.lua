local group = vim.api.nvim_create_augroup('FtJust', { clear = true })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = group,
  pattern = { 'justfile', '.justfile' },
  callback = function()
    vim.bo.filetype = 'just'
  end,
})
