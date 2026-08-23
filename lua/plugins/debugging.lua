return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = { "williamboman/mason.nvim" },
    },
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")

    require("dapui").setup()
    require("mason-nvim-dap").setup({
      ensure_installed = { "codelldb" },
    })

    local codelldb_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"
    if vim.fn.has("win32") == 1 then
      codelldb_path = codelldb_path .. ".exe"
    end

    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = codelldb_path,
        args = { "--port", "${port}" },
      },
    }

    dap.configurations.rust = {
      {
        name = "Launch Rust executable",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
      {
        name = "Launch Rust test executable",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to test executable: ", vim.fn.getcwd() .. "/target/debug/deps/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
    vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint)
    vim.keymap.set("n", "<leader>dc", dap.continue)
    vim.keymap.set("n", "<leader>dx", dap.terminate)
    vim.keymap.set("n", "<leader>do", dap.step_over)
  end,
}
