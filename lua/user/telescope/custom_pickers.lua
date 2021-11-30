local M = {}

local themes = require "telescope.themes"
local actions = require "telescope.actions"
local builtin = require "telescope.builtin"
local previewers = require "telescope.previewers"

-- Buffer switcher
function M.switch_buffers(opts)
  opts = opts or {}
  local theme_opts = themes.get_dropdown {
    border = true,
    previewer = false,
    initial_mode = "normal",
    sort_lastused = true,
    sort_mru = true,
    -- ignore_current_buffer = true
    -- path_display = { shorten = 5 },
    path_display = function(_, path)
      -- would be cool if instead of the path we could show the project
      local tail = require("telescope.utils").path_tail(path)
      return string.format("%s (%s)", tail, path)
    end,
    attach_mappings = function(_, map)
      map("i", "<c-d>", actions.delete_buffer)
      map("n", "<c-d>", actions.delete_buffer)
      map("n", "d", actions.delete_buffer)
      map("n", ";", actions.select_default)
      return true
    end,
  }
  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  builtin.buffers(opts)
end

function M.grep_current_buffer(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    winblend = lvim.winblend,
    border = true,
  }

  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  builtin.current_buffer_fuzzy_find(opts)
end

function M.dropdown_grep_current_buffer(opts)
  opts = opts or {}
  local theme_opts = themes.get_dropdown {
    winblend = lvim.winblend,
    border = true,
    previewer = false,
    -- border = false,
    layout_strategy = "vertical",
    layout_config = {
      vertical = { width = 0.9, height = 0.9, preview_height = 0.3 },
      -- prompt_position = "top",
      prompt_position = "bottom",
    },
  }

  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  builtin.current_buffer_fuzzy_find(opts)
end

function M.find_files(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    find_command = { "rg", "--hidden", "--files", "--follow", "--glob=!.git" },
    prompt_title = "~ files in project ~",
    layout_config = {
      bottom_pane = {
        prompt_position = "top",
        -- prompt_position = "bottom",
        -- height = 0.6,
      },
    },
  }
  opts = vim.tbl_deep_extend("force", theme_opts, opts)

  local ok = pcall(builtin.git_files, opts)
  if not ok then
    builtin.find_files(opts)
  end
end

function M.fuzzy_grep_files(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    -- sort_only_text = true,
    only_sort_text = true,
    disable_coordinates = true,
    path_display = { "hidden" },
    search = "",

    file_ignore_patterns = {
      "vendor/*",
      "node_modules",
      "%.jpg",
      "%.jpeg",
      "%.png",
      "%.svg",
      "%.otf",
      "%.ttf",
      "git/*",
    },
  }

  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  builtin.grep_string(opts)
end

function M.grep_files(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    -- find_command = { "rg", "--hidden", "--files", "--follow", "--glob=!.git" },
    -- word_match = "-w",
    -- sort_only_text = true,
    only_sort_text = true,
    disable_coordinates = true,
    path_display = { "hidden" },
    -- search = "",

    file_ignore_patterns = {
      "vendor/*",
      "node_modules",
      "%.jpg",
      "%.jpeg",
      "%.png",
      "%.svg",
      "%.otf",
      "%.ttf",
      "git/*",
    },
  }

  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  builtin.live_grep(opts)
end

function M.find_dotfiles(opts)
  opts = opts or {}

  local dotfiles_opts = { cwd = "~/.config", prompt_title = "~ dotfiles ~" }
  opts = vim.tbl_deep_extend("force", opts, dotfiles_opts)

  M.find_files(opts)
end

function M.find_lunarvim_config_files(opts)
  opts = opts or {}

  local config_files_opts = { cwd = "~/.config/lvim", prompt_title = "~ LunarVim config files ~" }
  opts = vim.tbl_deep_extend("force", opts, config_files_opts)

  M.find_files(opts)
end

function M.find_notes(opts)
  opts = opts or {}

  local config_files_opts = {
    cwd = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/svitax",
    prompt_title = "~ obsidian notes ~",
  }
  opts = vim.tbl_deep_extend("force", opts, config_files_opts)

  M.find_files(opts)
end

function M.grep_config_files(opts)
  opts = opts or {}

  local config_files_opts = { cwd = "~/.config/lvim", prompt_title = "~ grep LunarVim config files ~" }
  opts = vim.tbl_deep_extend("force", opts, config_files_opts)

  M.find_files(opts)
end

function M.grep_dotfiles(opts)
  opts = opts or {}

  local config_files_opts = { cwd = "~/.config", prompt_title = "~ grep dotfiles ~" }
  opts = vim.tbl_deep_extend("force", opts, config_files_opts)

  M.find_files(opts)
end

function M.grep_last_search(opts)
  opts = opts or {}

  -- \<getreg\>\C
  -- -> Subs out the search things
  local register = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", ""):gsub("\\C", "")

  opts.path_display = { "shorten" }
  opts.word_match = "-w"
  opts.search = register

  builtin.grep_string(opts)
end

-- function M.find_lunarvim_files(opts)
--   opts = opts or {}
--   local theme_opts = themes.get_ivy {
--     sorting_strategy = "ascending",
--     layout_strategy = "bottom_pane",
--     prompt_prefix = ">> ",
--     prompt_title = "~ LunarVim files ~",
--     cwd = get_runtime_dir(),
--     search_dirs = { utils.join_paths(get_runtime_dir(), "lvim"), lvim.lsp.templates_dir },
--   }
--   opts = vim.tbl_deep_extend("force", theme_opts, opts)
--   builtin.find_files(opts)
-- end

-- TODO: can't scroll down and up delta preview
local delta = previewers.new_termopen_previewer {
  get_command = function(entry)
    return { "git", "-c", "core.pager=delta", "-c", "delta.side-by-side=false", "diff", entry.value .. "^!" }
  end,
}

M.delta_git_commits = function(opts)
  opts = opts or {}
  opts.previewer = {
    delta,
    previewers.git_commit_message.new(opts),
    previewers.git_commit_diff_as_was.new(opts),
  }

  builtin.git_commits(opts)
end

M.delta_git_bcommits = function(opts)
  opts = opts or {}
  opts.previewer = {
    delta,
    previewers.git_commit_message.new(opts),
    previewers.git_commit_diff_as_was.new(opts),
  }

  builtin.git_bcommits(opts)
end

-- -- If I ever wanna make my own sessions telescope picker
-- M.sessions = function()
--   local actions = require "telescope.actions"
--   local action_state = require "telescope.actions.state"
--   local persistence = require "persistence"
--
--   local source_session = function(prompt_bufnr)
--     local selection = action_state.get_selected_entry()
--   end
--
--   require("telescope.builtin").find_files {
--     prompt_title = "Sessions",
--     -- entry_maker = Lib.make_entry.gen_from_file({cwd = cwd, path_display = path_display}),
--     cwd = "~/.config/nvim/sessions",
--     -- TOOD: support custom mappings?
--     attach_mappings = function(_, map)
--       actions.select_default:replace(source_session)
--       -- TODO add delete session
--       -- map("i", "<c-d>", SessionLensActions.delete_session)
--       return true
--     end,
--   }
-- end

return M
