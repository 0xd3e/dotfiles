vim.opt.colorcolumn = '88'

if vim.fn.executable('ty') == 1 then
  vim.lsp.enable('ty')
end
