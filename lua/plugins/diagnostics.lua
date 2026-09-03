return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
      -- Open all project diagnostics in Trouble.
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace diagnostics" },
      -- Open only diagnostics belonging to the current buffer.
      { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
    },
    init = function()
      vim.diagnostic.config({
        virtual_text = { spacing = 2, source = "if_many" },
        signs = true,
        underline = true,
        severity_sort = true,
        float = { border = "rounded", source = true, focusable = false },
      })

      local group = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
      vim.api.nvim_create_autocmd("CursorHold", {
        group = group,
        callback = function()
          vim.diagnostic.open_float(nil, { scope = "cursor" })
        end,
      })
      -- Focus a floating window containing the diagnostic under the cursor.
      vim.keymap.set("n", "<leader>e", function()
        vim.diagnostic.open_float(nil, { scope = "cursor", focusable = true })
      end, { desc = "Show diagnostic details" })
    end,
  },
}
