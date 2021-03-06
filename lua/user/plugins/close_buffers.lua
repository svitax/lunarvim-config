local M = {}

M.config = function()
  local status_ok, close_buffers = pcall(require, "close_buffers")
  if not status_ok then
    return
  end

  close_buffers.setup {
    filetype_ignore = {}, -- Filetype to ignore when running deletions
    file_glob_ignore = {}, -- File name glob pattern to ignore when running deletions (e.g. '*.md')
    file_regex_ignore = {}, -- File name regex pattern to ignore when running deletions (e.g. '.*[.]md')
    preserve_window_layout = { "this", "nameless" }, -- Types of deletion that should preserve the window layout
    next_buffer_cmd = nil, -- Custom function to retrieve the next buffer when preserving window layout
  }
  require("user.keymaps").set_close_buffers_keymaps()
end

return M
