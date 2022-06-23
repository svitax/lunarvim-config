local M = {}

function M.config()
  local Hydra = require "hydra"
  Hydra {
    hint = [[
 ^^^^^^     Move    ^^^^^^    ^^     Split         ^^^^    Size
 ^^^^^^-------------^^^^^^    ^^---------------    ^^^^-------------
 ^ ^ _k_ ^ ^   ^ ^ _K_ ^ ^    _s_: horizontally    _+_ _-_: height
 _h_ ^ ^ _l_   _H_ ^ ^ _L_    _v_: vertically      _>_ _<_: width
 ^ ^ _j_ ^ ^   ^ ^ _J_ ^ ^    _q_: close           ^ _=_ ^: equalize
 focus ^^^^^^  window
 ^ ^ ^ ^ ^ ^   ^ ^ ^ ^ ^ ^    _b_: choose buffer   ^ ^ ^ ^    _<Esc>_
]],
    config = {
      invoke_on_body = true,
      hint = {
        border = "rounded",
      },
    },
    mode = "n",
    body = "<leader>o",
    heads = {
      -- Move focus
      { "h", "<C-w>h" },
      { "j", "<C-w>j" },
      { "k", "<C-w>k" },
      { "l", "<C-w>l" },
      -- Move window
      { "H", "<Cmd>WinShift left<CR>" },
      { "J", "<Cmd>WinShift down<CR>" },
      { "K", "<Cmd>WinShift up<CR>" },
      { "L", "<Cmd>WinShift right<CR>" },
      -- Split
      { "s", "<C-w>s" },
      { "v", "<C-w>v" },
      { "q", "<Cmd>try | close | catch | endtry<CR>", { desc = "close window" } },
      -- Size
      { "+", "<C-w>+" },
      { "-", "<C-w>-" },
      { ">", "2<C-w>>", { desc = "increase width" } },
      { "<", "2<C-w><", { desc = "decrease width" } },
      { "=", "<C-w>=", { desc = "equalize" } },
      --
      { "b", "<Cmd>BufExplorer<CR>", { exit = true, desc = "choose buffer" } },
      { "<Esc>", nil, { exit = true } },
    },
  }
end

return M
