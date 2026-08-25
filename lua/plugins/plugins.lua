return {
  { "sainnhe/everforest", name="everforest", priority=999 },
  { 'nvim-telescope/telescope.nvim', tag='0.1.6', dependencies = { 'nvim-lua/plenary.nvim' } },
  { "nvim-treesitter/nvim-treesitter", build= ":TSUpdate" },
  { "xiyaowong/transparent.nvim", name="transparent" },
  { "gelguy/wilder.nvim", name = "wilder" },
  { "nvim-neo-tree/neo-tree.nvim", branch= "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
      }
  },
  {
    "akinsho/toggleterm.nvim",config = true
  },
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
    "junegunn/fzf.vim", name="fzf"
  },
  {
    "sphamba/smear-cursor.nvim", name="smear"
  },
}
