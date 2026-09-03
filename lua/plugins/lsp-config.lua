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
    opts = {
      -- clangd is enabled below when it exists, but Mason cannot install its
      -- prebuilt binary on NixOS.
      ensure_installed = { "lua_ls", "pyright", "ts_ls", "nil_ls", "bashls", "ltex_plus" },
      automatic_enable = { exclude = { "rust_analyzer" } },
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local servers = { "lua_ls", "pyright", "clangd", "ts_ls", "nil_ls", "bashls", "ltex_plus" }
      for _, server in ipairs(servers) do
        vim.lsp.config(server, { capabilities = capabilities })
      end

      vim.lsp.config("ltex_plus", {
        capabilities = capabilities,
        filetypes = { "tex", "plaintex", "bib", "markdown" },
        settings = { ltex = { language = "en-US" } },
      })

      -- rust_analyzer is intentionally omitted here. rustaceanvim is its sole
      -- owner, which avoids duplicate clients and conflicting configuration.
      vim.lsp.enable(servers)
    end,
  },
  -- Show documentation for the symbol under the cursor.
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {}),
  -- Jump to a symbol's definition or list its references.
  vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {}),
  vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, {}),
  -- Select an LSP code action while previewing the proposed edit.
  vim.keymap.set('n', '<leader>ca', function()
    require("actions-preview").code_actions()
  end, { desc = "Preview code actions" }),
  -- Rename the symbol under the cursor throughout the project.
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {}),
}
