--
-- Options
--

vim.o.hlsearch = false -- Set highlight on search
vim.o.number = true -- Make line numbers default
vim.o.mouse = '' -- Disable mouse
vim.o.breakindent = true -- Enable break indent
vim.o.undofile = true -- Save undo history
vim.o.showmode = false -- Do not show the mode becuase it is part of the status bar
vim.o.laststatus = 3 -- Global status line
vim.o.signcolumn = 'yes' -- Keep signcolumn on by default
vim.o.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience
vim.o.termguicolors = true -- Enable 24-bit RGB color in TUI
vim.o.cursorline = true -- Show cursorline
vim.o.relativenumber = true -- Show line numbers relative to the current line
vim.o.scrolloff = 10 -- Always show 10 lines before and below the cursor
vim.o.splitright = true -- New window on the right when splitting
vim.o.splitbelow = true -- New window below when splitting

-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim
end)

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.timeoutlen = 300
vim.o.updatetime = 250

-- Show whitespace characters
vim.opt.listchars = {
  tab = '→ ',
  trail = '‧',
  lead = '‧',
  nbsp = '+',
  extends = '↣',
  precedes = '↢',
}
vim.o.list = true

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Install plugins
require('lazy').setup({
  require('my.plugins.which_key'),
  require('my.plugins.telescope'),
  require('my.plugins.cmp'),
  require('my.plugins.lspconfig'),
  require('my.plugins.nightfox'),
  require('my.plugins.lualine'),
  require('my.plugins.comment'),
  require('my.plugins.treesitter'),
  require('my.plugins.surround'),
  require('my.plugins.99'),
  require('my.plugins.oil'),
}, {})

--
-- Basic Keymaps
--

-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

--
-- Further configuration
--

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
