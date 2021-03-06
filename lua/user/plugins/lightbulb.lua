local M = {}

M.config = function()
  local bulb_ok, lightbulb = pcall(require, "nvim-lightbulb")
  if not bulb_ok then
    return
  end

  local icons_ok, icons = pcall(require, "user.icons")
  if not icons_ok then
    return
  end

  lightbulb.setup {
    sign = {
      enabled = true,
      -- Priority of the gutter sign
      priority = 10,
    },
    autocmd = {
      enabled = true,
      -- see :help autocmd-pattern
      pattern = { "*" },
      -- see :help autocmd-events
      events = { "CursorHold", "CursorHoldI" },
    },
  }
  vim.fn.sign_define("LightBulbSign", { text = icons.ui.Lightbulb, texthl = "LightBulbVirtualText" })
  -- text = "",
  local c = require("fennec-gruvbox.colors").config()
end

return M
