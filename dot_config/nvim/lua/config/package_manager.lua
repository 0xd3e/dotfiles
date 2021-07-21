--
-- Paq
--
-- Initial setup:
-- git clone --depth=1 https://github.com/savq/paq-nvim.git \
--   "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim
--

require 'paq' {
	'savq/paq-nvim', -- The package manager itself
	'hrsh7th/nvim-compe', -- Completion
	'neovim/nvim-lspconfig', -- Language server client
	'nvim-treesitter/nvim-treesitter', -- Syntax highlighting and stuff
	'nvim-lua/plenary.nvim', -- Lua function library (dependency of telescope)
	'nvim-lua/popup.nvim', -- Popup API for Neovim (dependency of telescope)
	'nvim-telescope/telescope.nvim', -- Fuzzy finder for files, buffers, etc
}
