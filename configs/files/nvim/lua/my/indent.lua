--- Settings based on https://gist.github.com/LunarLambda/4c444238fb364509b72cfb891979f1dd
local M = {}

--- Indentation settings using spaces
function M.space(width)
  vim.opt_local.expandtab = true
  vim.opt_local.tabstop = width
  vim.opt_local.shiftwidth = width
  vim.opt_local.softtabstop = -1
  vim.opt_local.smarttab = true
end

--- Indentation settings using tabs
function M.tab(width)
  vim.opt_local.expandtab = false
  vim.opt_local.tabstop = width
  vim.opt_local.shiftwidth = 0
  vim.opt_local.softtabstop = 0
  vim.opt_local.smarttab = true
end

return M
