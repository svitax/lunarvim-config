local M = {}

M.config = function()
  lvim.builtin.terminal.open_mapping = [[…]] -- alt+; in macos
  lvim.builtin.terminal.execs = {
    { "lazygit", "gg", "LazyGit" },
    { "cobib", "ob", "Bibliography (Cobib)" },
    { "gomi --restore", "fr", "Restore deleted files (Gomi)" },
  }
  -- lvim.builtin.terminal.float_opts.width = vim.fn.float2nr(vim.o.columns * 0.99)
  -- lvim.builtin.terminal.float_opts.height = vim.fn.float2nr(vim.o.lines * 0.87)

  -- lvim.builtin.terminal.on_config_done = function ()
  --   -- TODO find out how to quit a terminal window with q
  -- end
end

return M