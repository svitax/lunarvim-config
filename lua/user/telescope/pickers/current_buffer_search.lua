return function()
  local themes = require "telescope.themes"
  local builtin = require "telescope.builtin"
  local opts = {
    -- sort_lastused = true,
    -- sort_mru = true,
    -- sorting_strategy = "ascending",
  }
  local theme_opts = themes.get_dropdown {
    winblend = lvim.winblend,
    layout_strategy = "vertical",
    -- border = true,
    -- previewer = true,
    -- shorten_path = false,
    layout_config = {
      vertical = { width = 0.9, height = 0.9, preview_height = 0.3 },
      -- prompt_position = "top",
      prompt_position = "bottom",
    },
  }

  local grep_conf = vim.tbl_deep_extend("force", opts, theme_opts)
  builtin.current_buffer_fuzzy_find(grep_conf)
end
