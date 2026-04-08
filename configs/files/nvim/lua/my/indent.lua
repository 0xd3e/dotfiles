local M = {}

--- Indentation settings using spaces
function M.space(width)
  vim.opt_local.expandtab = true
  vim.opt_local.shiftwidth = width
  vim.opt_local.softtabstop = -1
  vim.opt_local.smarttab = true
end

--- Indentation settings using tabs
function M.tab(width)
  vim.opt_local.tabstop = width
  vim.opt_local.shiftwidth = 0
  vim.opt_local.softtabstop = -1
end

return M
