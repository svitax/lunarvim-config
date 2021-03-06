local M = {}

M.config = function()
  vim.g.matchup_matchparen_deferred = 1
  vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
  lvim.builtin.treesitter.matchup.enable = true
end

return M
