return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "angularls", "ansiblels", "bashls", "gopls", "lua_ls",
        "nginx_language_server", "pyright", "tofu_ls", "ts_ls", "vimls",
      },
      -- Enable only the curated list below. This avoids duplicate Python and
      -- Rust clients when several Mason packages happen to be installed.
      automatic_enable = false,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP hover" }))
          vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
          vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "List references" }))
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
          vim.keymap.set("n", "<leader>ca", function()
            require("actions-preview").code_actions()
          end, vim.tbl_extend("force", opts, { desc = "Preview code actions" }))
        end,
      })

      local servers = {
        angularls = {},
        ansiblels = {},
        bashls = {},
        clangd = {}, -- supplied by NixOS rather than Mason
        gopls = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          },
        },
        nginx_language_server = {},
        nil_ls = {}, -- supplied by NixOS rather than Mason
        pyright = {},
        tofu_ls = {},
        ts_ls = {},
        vimls = {},
        ltex_plus = {
          filetypes = { "tex", "plaintex", "bib", "markdown" },
          settings = { ltex = { language = "en-US" } },
        },
      }

      for server, config in pairs(servers) do
        config.capabilities = capabilities
        vim.lsp.config(server, config)
      end

      -- rust_analyzer is intentionally omitted here. rustaceanvim is its sole
      -- owner, which avoids duplicate clients and conflicting configuration.
      vim.lsp.enable(vim.tbl_keys(servers))
    end,
  },
}
