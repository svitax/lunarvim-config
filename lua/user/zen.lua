local M = {}

M.config = function()
  local status_ok, zen_mode = pcall(require, "zen-mode")
  if not status_ok then
    return
  end

  zen_mode.setup {
    window = {
      backdrop = 1,
      height = 0.9, -- height of the Zen window
      width = 0.85,
      options = {
        signcolumn = "no", -- disable signcolumn
        number = false, -- disable number column
        relativenumber = false, -- disable relative numbers
        -- cursorline = false, -- disable cursorline
        -- cursorcolumn = false, -- disable cursor column
        -- foldcolumn = "0", -- disable fold column
        -- list = false, -- disable whitespace characters
      },
    },
    plugins = {
      gitsigns = { enabled = false }, -- disables git signs
      tmux = { enabled = false },
      twilight = { enabled = true },
    },
    -- IndentBlanklineDisable
    on_open = function()
      vim.lsp.diagnostic.set_virtual_text = false
      vim.cmd [[
          set foldlevel=10
          hi LspReferenceRead cterm=bold ctermbg=red guibg=#24283b
          hi LspReferenceText cterm=bold ctermbg=red guibg=#24283b
          hi LspReferenceWrite cterm=bold ctermbg=red guibg=#24283b
          ]]
    end,
    on_close = function()
      vim.lsp.diagnostic.set_virtual_text = {
        prefix = "",
        spacing = 0,
      }

      -- IndentBlanklineEnable
      vim.cmd [[
          set foldlevel=5
          hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
          hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
          hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
          ]]
    end,
  }
end

return M
