return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {},
  config = function()
    local wk = require('which-key')
    local tb = require('telescope.builtin')

    wk.add({
      { '<leader>?', tb.oldfiles, desc = 'Find recently opened files' },
      {
        '<leader>/',
        function()
          local tt = require('telescope.themes')
          tb.current_buffer_fuzzy_find(tt.get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        desc = 'Fuzzily search in current buffer',
      },
      { '<leader>s', group = 'Search' },
      { '<leader>sb', tb.buffers, desc = 'Search Buffers' },
      { '<leader>sd', tb.diagnostics, desc = 'Search Diagnostics' },
      { '<leader>sf', tb.find_files, desc = 'Search Files' },
      { '<leader>sg', tb.live_grep, desc = 'Search by Grep' },
      { '<leader>sh', tb.help_tags, desc = 'Search Help' },
      { '<leader>sw', tb.grep_string, desc = 'Search Current Word' },
    })

    -- Add LSP specific key bindings when LSP attaches.
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach-bindings', { clear = true }),
      callback = function(args)
        local bufnr = args.buf

        wk.add({
          { 'K', vim.lsp.buf.hover, desc = 'Hover Documentation' },
          { '<C-k>', vim.lsp.buf.signature_help, desc = 'Signature Documentation' },
          { '<leader>l', group = 'LSP' },
          { '<leader>la', vim.lsp.buf.code_action, desc = 'LSP Code Action' },
          { '<leader>lr', vim.lsp.buf.rename, desc = 'LSP Rename' },
          { '<leader>lg', group = 'LSP Goto' },
          { '<leader>lgd', vim.lsp.buf.definition, desc = 'LSP Goto Definition' },
          { '<leader>lgi', vim.lsp.buf.implementation, desc = 'LSP Goto Implementation' },
          { '<leader>lgr', tb.lsp_references, desc = 'LSP Goto References' },
          { '<leader>lgt', vim.lsp.buf.type_definition, desc = 'LSP Goto Type Definition' },
          { '<leader>ls', group = 'LSP Symbols' },
          { '<leader>lsd', tb.lsp_document_symbols, desc = 'LSP Document Symbols' },
          { '<leader>lsw', tb.lsp_dynamic_workspace_symbols, desc = 'LSP Workspace Symbols' },
          { '<leader>lw', group = 'LSP Workspace' },
          { '<leader>lwa', vim.lsp.buf.add_workspace_folder, desc = 'LSP Workspace Add Folder' },
          { '<leader>lwr', vim.lsp.buf.remove_workspace_folder, desc = 'LSP Workspace Remove Folder' },
        }, { buffer = bufnr })
      end,
    })
  end,
}
