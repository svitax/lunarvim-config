-- lvim.lang.javascriptreact.formatters = {
--   {
--     exe = "prettierd",
--   },
--   {
--     exe = "eslint_d",
--   },
-- }
-- lvim.lang.javascriptreact.linters = {
--   {
--     exe = "eslint_d",
--   },
-- }
local bufnr = vim.api.nvim_get_current_buf()
local opts = { silent = true }
vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lF", ":TSLspRenameFile<CR>", opts)
vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lO", ":TSLspOrganize<CR>", opts)
vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lI", ":TSLspImportAll<CR>", opts)
