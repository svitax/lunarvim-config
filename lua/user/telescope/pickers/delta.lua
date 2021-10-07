-- Delta

-- Implement delta as previewer for diffs

-- Requires git-delta, e.g. on macOS
-- brew install git-delta

-- TODO can't seem to scroll up or down with just <c-u>/<c-d> in the delta previewer
-- TODO need to <c-u>/<c-d> and scroll with mouse to see everything
local M = {}

local builtin = require "telescope.builtin"
local previewers = require "telescope.previewers"

local delta = previewers.new_termopen_previewer {
  get_command = function(entry)
    -- this is for status
    -- You can get the AM things in entry.status. So we are displaying file if entry.status == '??' or 'A '
    -- just do an if and return a different command
    if entry.status == "??" or "A " then
      -- return { "git", "-c", "core.pager=delta", "-c", "delta.side-by-side=false", "diff", entry.value }
      return { "git", "-c", "core.pager=delta", "-c", "delta.side-by-side=true", "diff", entry.value }
    end
    -- note we can't use pipes
    -- this command is for git_commits and git_bcommits
    -- return { "git", "-c", "core.pager=delta", "-c", "delta.side-by-side=false", "diff", entry.value .. "^!" }
    return { "git", "-c", "core.pager=delta", "-c", "delta.side-by-side=true", "diff", entry.value .. "^!" }
  end,
}

-- TODO delta_git_commits is kinda buggy
M._git_commits = function(opts)
  opts = opts or {}
  -- make the layout big so I can read everything with my large font and side-by-side preview
  opts.layout_config = {
    preview_width = 0.7,
    width = 0.96,
    height = 0.99,
  }
  opts.previewer = delta
  builtin.git_commits(opts)
end

-- TODO delta_git_bcommits is also kinda buggy
M.git_bcommits = function(opts)
  opts = opts or {}
  -- make the layout big so I can read everything with my large font and side-by-side preview
  opts.layout_config = {
    preview_width = 0.7,
    width = 0.96,
    height = 0.99,
  }
  opts.previewer = delta
  builtin.git_bcommits(opts)
end

M.git_status = function(opts)
  opts = opts or {}
  -- make the layout big so I can read everything with my large font and side-by-side preview
  opts.layout_config = {
    preview_width = 0.7,
    width = 0.96,
    height = 0.99,
  }
  opts.previewer = delta
  builtin.git_status(opts)
end

return M
