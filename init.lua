vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " " 

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
vim.fn.system({
  "git",
  "clone",
  "--filter=blob:none",
  "https://github.com/folke/lazy.nvim.git",
  "--branch=stable",
  lazypath,
})
end 

vim.opt.rtp:prepend(lazypath)

--vim.opt.swapfile = false 
  vim.opt.directory = vim.fn.stdpath("state") .. "/swap//"

--local opts = {}

--Lua import setups--

--require("lazy").setup(plugins, opts) --lazy
require("lazy").setup("plugins")
require("nvim-treesitter").setup({ --treesitter
  ensure_installed = {"lua", "javascript"},
  highlight = { enable = true },
  indent = { enable = true }
})
require("transparent").setup()
require("toggleterm").setup()


local wilder = require('wilder')
wilder.setup({modes = {':', '/', '?'}})

--Colorscheme--
vim.cmd.colorscheme("everforest")

--Neo-tree transparent
vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NeoTreeSignColumn", { bg = "NONE", ctermbg = "NONE" })

--Vim keybinds--
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-l>', builtin.live_grep, {})
vim.keymap.set('n', '<C-n>', ':Neotree toggle filesystem reveal float<CR>')
vim.keymap.set('n', '<C-t>', ':ToggleTerm toggle size=17 direction=horizontal dir=.<CR>')
vim.keymap.set('n', '<leader>w', ':SudaWrite<CR>')
vim.keymap.set('n', '<leader>q', ':q!<CR>')
vim.keymap.set('n', '<leader>wq', ':wq<CR>')
vim.keymap.set('n', '<leader>s', 'w<CR>')
vim.keymap.set('n', '<leader>r', ':lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-f>', '<cmd>fzf<CR>')

--Clipboard
vim.opt.clipboard = "unnamedplus"

--Timeout
vim.o.timeoutlen = 450
