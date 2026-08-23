return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("nil", {
          capabilities = capabilities,
          flake = {autoarchive = true},
      })

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
      })

      vim.lsp.config("rust_analyzer", {
        capabilities = capabilities,
      })

      vim.lsp.config("pyright", {
        capabilities = capabilities,
      })

      vim.lsp.config("nil_ls", {
        capabilities = capabilities,
      })

      vim.lsp.enable({ "lua_ls", "rust_analyzer", "pyright", "nil_ls" })
    end,
  },
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {}),
  vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {}),
  vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, {}),
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {}),
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {}),
}
