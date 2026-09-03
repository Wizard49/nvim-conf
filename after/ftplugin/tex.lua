vim.opt_local.conceallevel = 2

-- Save, start continuous compilation, and open the PDF viewer after the first
-- successful build. The bang keeps repeated presses from stopping latexmk.
vim.keymap.set("n", "<leader>lc", function()
  vim.cmd.update()
  vim.cmd("VimtexCompile!")
end, {
  buffer = true,
  desc = "Compile LaTeX and open live PDF",
})
-- Open the generated PDF with the configured desktop viewer.
vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<cr>", {
  buffer = true,
  desc = "Open compiled PDF",
})
-- Populate the quickfix window with errors from the latest compilation.
vim.keymap.set("n", "<leader>ll", "<cmd>VimtexErrors<cr>", {
  buffer = true,
  desc = "Show LaTeX errors",
})
-- Stop any running VimTeX compiler process.
vim.keymap.set("n", "<leader>lk", "<cmd>VimtexStop<cr>", {
  buffer = true,
  desc = "Stop LaTeX compilation",
})
