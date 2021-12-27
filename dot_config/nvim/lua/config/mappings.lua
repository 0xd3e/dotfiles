local mappings = {}

function mappings.setup()
  -- Use <Space> as leader
  vim.api.nvim_set_keymap('n', '<Space>', '', {}) -- Remove mapping of <Space> in normal mode
  vim.g.mapleader = ' ' -- Map <Space> to leader

  -- Telescope
  vim.api.nvim_set_keymap('n', '<Leader>ff', '<cmd>lua require("telescope.builtin").find_files()<CR>', {noremap = true})
  vim.api.nvim_set_keymap('n', '<Leader>fb', '<cmd>lua require("telescope.builtin").buffers()<CR>', {noremap = true})
end

return mappings
