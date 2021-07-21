-- Use <Space> as leader
vim.api.nvim_set_keymap('n', '<Space>', '', {}) -- Remove mapping of <Space> in normal mode
vim.g.mapleader = ' ' -- Map <Space> to leader

-- Map <Tab> and <S-Tab> for item selection during completion
vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', {expr = true})
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', {expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})

-- Telescope
vim.api.nvim_set_keymap('n', '<Leader>ff', '<cmd>lua require("telescope.builtin").find_files()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>fb', '<cmd>lua require("telescope.builtin").buffers()<CR>', {noremap = true})
