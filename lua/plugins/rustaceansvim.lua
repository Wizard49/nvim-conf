return {
  'mrcjkb/rustaceanvim',
  version = '^5', -- Recommended
  lazy = false, -- The plugin automatically lazy-loads itself on 'FileType rust'
  init = function()
    local capabilities = vim.tbl_deep_extend(
      'force',
      require('rustaceanvim.config.server').create_client_capabilities(),
      require('cmp_nvim_lsp').default_capabilities()
    )

    vim.g.rustaceanvim = {
      -- Plugin-specific tools
      tools = {
        hover_actions = {
          auto_focus = true,
        },
      },
      -- LSP configuration
      server = {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          vim.keymap.set('n', '<leader>a', function()
            vim.cmd.RustLsp('codeAction')
          end, { silent = true, buffer = bufnr, desc = 'Rust code action' })

          vim.keymap.set('n', 'K', function()
            vim.cmd.RustLsp({ 'hover', 'actions' })
          end, { silent = true, buffer = bufnr, desc = 'Rust hover actions' })
        end,
        default_settings = {
          -- rust-analyzer specific settings
          ['rust-analyzer'] = {
            cargo = {
              allFeatures = true,
            },
            check = {
              command = "clippy",
            },
            diagnostics = {
              -- rust-analyzer marks cfg-disabled/macro-adjacent code as
              -- unnecessary, which Neovim renders as greyed-out text.
              disabled = { "inactive-code" },
            },
          },
        },
      },
    }
  end
}
