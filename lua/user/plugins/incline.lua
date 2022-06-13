local M = {}

local function truncate(str, max_len)
  assert(str and max_len, "string and max_len must be provided")
  return vim.api.nvim_strwidth(str) > max_len and str:sub(1, max_len) .. "…" or str
end

local function render(props)
  local fmt = string.format
  local devicons = require "nvim-web-devicons"
  local bufname = vim.api.nvim_buf_get_name(props.buf)
  if bufname == "" then
    return "[No name]"
  end
  local ret = vim.api.nvim_get_hl_by_name("Directory", true)
  local directory_color = string.format("#%06x", ret["foreground"])
  local parts = vim.split(vim.fn.fnamemodify(bufname, ":."), "/")
  local result = {}
  for idx, part in ipairs(parts) do
    if next(parts, idx) then
      vim.list_extend(result, {
        { truncate(part, 20) },
        { fmt(" %s ", ""), guifg = directory_color },
      })
    else
      table.insert(result, { part, gui = "bold", guisp = directory_color })
    end
  end
  local icon, color = devicons.get_icon_color(bufname, nil, { default = true })
  table.insert(result, #result, { icon .. " ", guifg = color })
  return result
end

M.config = function()
  local status_ok, incl = pcall(require, "incline")
  if not status_ok then
    return
  end

  incl.setup {
    window = {
      width = "fit",
      placement = {
        vertical = "top",
        horizontal = "left",
      },
      margin = {
        horizontal = 0,
      },
    },
    render = render,
    -- render = "basic",
  }
end

return M
