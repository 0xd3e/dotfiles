return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'j-hui/fidget.nvim', opts = {} },
    { 'folke/neodev.nvim', opts = {} },
    { 'saghen/blink.cmp' },
  },
  config = function()
    --
    -- Format buffer on save
    --

    -- Create one augroup per client to make sure that multiple clients can
    -- connect to the same buffer.
    local augroups = {}
    local get_augroup = function(client)
      if not augroups[client.id] then
        local name = 'lsp-format-' .. client.name
        local id = vim.api.nvim_create_augroup(name, { clear = true })

        augroups[client.id] = id
      end

      return augroups[client.id]
    end

    -- Add autocmd to format buffer on save when lsp attaches.
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach-format', { clear = true }),
      callback = function(args)
        local client_id = args.data.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local bufnr = args.buf

        -- Do nothing if the LSP doesn't support formatting.
        if not client.server_capabilities.documentFormattingProvider then
          return
        end

        -- Add user command to format code.
        vim.api.nvim_create_user_command('Format', function()
          vim.lsp.buf.format({
            async = false,
            filter = function(c)
              return c.id == client.id
            end,
          })
        end, {})

        vim.api.nvim_create_autocmd('BufWritePre', {
          group = get_augroup(client),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({
              async = false,
              filter = function(c)
                return c.id == client.id
              end,
            })
          end,
        })
      end,
    })

    --
    -- Servers
    --
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Go
    vim.lsp.config('gopls', { capabilities = capabilities })
    vim.lsp.enable('gopls')

    -- Python
    vim.lsp.config('pylsp', {
      capabilities = capabilities,
      settings = {
        pylsp = {
          plugins = {
            ruff = { enabled = true },
            pylsp_mypy = { enabled = true },
          },
        },
      },
    })
    vim.lsp.enable('pylsp')

    -- JavaScript / TypeScript / Vue
    vim.lsp.config('ts_ls', {
      capabilities = capabilities,
      init_options = {
        plugins = {
          {
            name = '@vue/typescript-plugin',
            location = vim.fn.expand('$HOME/.local/node_packages/node_modules/@vue/typescript-plugin'),
            languages = { 'vue' },
            configNamespace = 'typescript',
          },
        },
      },
      filetypes = {
        'typescript',
        'javascript',
        'javascriptreact',
        'typescriptreact',
        'vue',
      },
    })
    vim.lsp.enable('ts_ls')

    vim.lsp.config('biome', { capabilities = capabilities })
    vim.lsp.enable('biome')

    vim.lsp.config('vue_ls', { capabilities = capabilities })
    vim.lsp.enable('vue_ls')

    vim.lsp.config('elixirls', {
      cmd = { 'elixir-ls' },
      capabilities = capabilities,
    })
    vim.lsp.enable('elixirls')
  end,
}
