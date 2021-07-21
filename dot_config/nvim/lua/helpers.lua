local M = {}

--
-- Check if a package identified by its name is installed and loaded
--
function M.package_installed(name)
	local switch = {
		['nvim-lspconfig'] = function()
			return vim.g.lspconfig ~= nil and true or false
		end,
		['nvim-treesitter'] = function()
			return vim.g.loaded_nvim_treesitter ~= nil and true or false
		end,
	}

	local f = switch[name]
	if (f) then
		f()
	else
		return false
	end
end

--
-- Create an augroup
--
-- This is necessary because the Neovim Lua API doesn't support augroups yet
--
function M.create_augroup(autocmds, name)
	vim.cmd('augroup ' .. name)
	vim.cmd('autocmd!')

	for _, autocmd in ipairs(autocmds) do
		vim.cmd('autocmd ' .. table.concat(autocmd, ' '))
	end

	vim.cmd('augroup END')
end

return M
