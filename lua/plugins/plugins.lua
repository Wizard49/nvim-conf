return {
  { "sainnhe/everforest", name="everforest", priority=999 },
  { 'nvim-telescope/telescope.nvim', tag='0.1.6', dependencies = { 'nvim-lua/plenary.nvim' } },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local parsers = {
        "angular", "bash", "bibtex", "c", "cmake", "cpp", "css", "go",
        "html", "javascript", "json", "latex", "lua", "markdown",
        "markdown_inline", "nix", "python", "rust", "terraform",
        "typescript", "vim", "vimdoc", "yaml",
      }

      require("nvim-treesitter").install(parsers)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = parsers,
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      require("nvim-autopairs").setup({ check_ts = true })
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "aznhe21/actions-preview.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {},
  },
  -- { "xiyaowong/transparent.nvim", name="transparent" },
  { "nvim-neo-tree/neo-tree.nvim", branch= "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
      }
  },
  { "akinsho/toggleterm.nvim", opts = {} },
  {
    "lambdalisue/suda.vim", name="suda"
  },
  {
    "vhyrro/luarocks.nvim", priority=1000, name='luarocks',
    config=true,
  },
  {
    "nvim-lualine/lualine.nvim", dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = { left = "|", right = "|"},
        },
      })
    end,
  },
  {
    "lervag/vimtex",
    name = "vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        options = { "-verbose", "-file-line-error", "-synctex=1", "-interaction=nonstopmode" },
      }
      -- Evince opens in its own window and automatically reloads the PDF after
      -- every successful latexmk build.
      vim.g.vimtex_view_method = "general"
      vim.g.vimtex_view_general_viewer = "evince"
      vim.g.vimtex_view_automatic = 1
      vim.g.vimtex_quickfix_mode = 0
    end,
  },
  {
    "jbyuki/nabla.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "tex", "plaintex" },
    config = function()
      local function setup_buffer(bufnr)
        require("nabla").enable_virt({ autogen = true, silent = true })
        -- Render the LaTeX equation under the cursor in a floating preview.
        vim.keymap.set("n", "<leader>lp", require("nabla").popup, {
          buffer = bufnr,
          desc = "Preview equation under cursor",
        })
      end

      setup_buffer(vim.api.nvim_get_current_buf())
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "tex", "plaintex" },
        callback = function(args)
          setup_buffer(args.buf)
        end,
      })
    end,
  },
  {
    "nvim-tree/nvim-web-devicons", lazy = true,
  },
  {
    "gelguy/wilder.nvim",
    name = "wilder",
    config = function()
      require("wilder").setup({ modes = { ":", "/", "?" } })
    end,
  },
}
