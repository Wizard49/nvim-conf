vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.completeopt = { "menu", "menuone", "noselect" }

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

vim.opt.directory = vim.fn.stdpath("state") .. "/swap//"

require("lazy").setup("plugins", {
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
})

vim.filetype.add({
  extension = {
    c0 = "c",
  },
})

--Colorscheme--
vim.cmd.colorscheme("everforest")

--Neo-tree transparent
vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NeoTreeSignColumn", { bg = "NONE", ctermbg = "NONE" })

--Vim keybinds--
vim.keymap.set('n', '<C-p>', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<C-l>', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<C-n>', ':Neotree toggle filesystem reveal float<CR>')
vim.keymap.set('n', '<C-t>', ':ToggleTerm toggle size=17 direction=horizontal dir=.<CR>')
vim.keymap.set('n', '<leader>w', ':SudaWrite<CR>')
vim.keymap.set('n', '<leader>q', ':q!<CR>')
vim.keymap.set('n', '<leader>wq', ':wq<CR>')
vim.keymap.set('n', '<leader>s', 'w<CR>')
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- vim.keymap.set('n', '<C-f>', '<cmd>fzf<CR>')

--Clipboard
vim.opt.clipboard = "unnamedplus"

--Timeout
vim.o.timeoutlen = 450
