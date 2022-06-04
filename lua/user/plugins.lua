local M = {}

M.config = function()
  -- Additional Plugins
  lvim.plugins = {
    { "luisiacc/gruvbox-baby" },
    {
      "svitax/fennec-gruvbox.nvim",
      branch = "gruvbox-baby",
    },
    {
      "SmiteshP/nvim-gps",
      requires = "nvim-treesitter/nvim-treesitter",
      config = require("nvim-gps").setup {},
    },
    {
      "gfeiyou/command-center.nvim",
      requires = "nvim-telescope/telescope.nvim",
      config = require("user.plugins.command_center").config(),
    },
    {
      "mrjones2014/legendary.nvim",
      config = require("user.plugins.legendary").config(),
    },
    {
      "stevearc/dressing.nvim",
      config = require("user.plugins.dressing").config(),
    },
    {
      "norcalli/nvim-colorizer.lua",
      config = require("user.plugins.colorizer").config(),
      -- event = "BufRead",
    },
    {
      "folke/trouble.nvim",
      cmd = "TroubleToggle",
    },
    {
      "numToStr/Navigator.nvim",
      config = require("Navigator").setup(),
    },
    {
      "kwkarlwang/bufjump.nvim",
      config = require("bufjump").setup(),
    },
    {
      "ghillb/cybu.nvim",
      requires = { "kyazdani42/nvim-web-devicons" }, --optional
      config = require("user.plugins.cybu").config(),
    },
    {
      "kazhala/close-buffers.nvim",
      event = "BufRead",
      config = require("user.plugins.close_buffers").config(),
      -- cmd = { "BDelete", "BDelete!", "BWipeout", "BWipeout!" },
    },
    { -- TODO: must not override my q/<Esc> (I need my <Esc> to quit from shell scripts and options in lf)
      "is0n/fm-nvim",
      cmd = { "Lf" },
      config = require("user.plugins.fm").config(),
    },
    {
      "kdheepak/lazygit.nvim",
      cmd = { "LazyGit", "LazyGitConfig" },
    },
    { "wakatime/vim-wakatime" },
    {
      "petertriho/nvim-scrollbar",
      config = require("user.plugins.scrollbar").config(),
    },
    {
      "kevinhwang91/nvim-hlslens",
      config = require("user.plugins.hlslens").config(),
    },
    {
      "chentoast/marks.nvim",
      config = require("user.plugins.marks").config(),
    },
    {
      "declancm/cinnamon.nvim",
      config = require("user.plugins.cinnamon").config(),
    },
    {
      "ray-x/lsp_signature.nvim",
      config = require("user.plugins.lsp_signature").config(),
    },
    {
      "echasnovski/mini.nvim",
      branch = "stable",
      config = function()
        require("user.plugins.surround").config()
        require("user.plugins.indentscope").config()
      end,
    },
    {
      "andymass/vim-matchup",
      config = require("user.plugins.matchup").config(),
      -- event = "CursorMoved",
    },
    {
      "nvim-telescope/telescope-hop.nvim",
      -- config = -- inside telescope file
    },
    {
      "rcarriga/nvim-dap-ui",
      requires = { "mfussenegger/nvim-dap" },
      config = require("dapui").setup {},
    },
    {
      "kosayoda/nvim-lightbulb",
      config = require("user.plugins.lightbulb").config(),
    },
    {
      "ldelossa/gh.nvim",
      requires = { { "ldelossa/litee.nvim" } },
      config = require("user.plugins.gh").config(),
    },
    {
      "weilbith/nvim-code-action-menu",
      cmd = "CodeActionMenu",
    },
    {
      "ggandor/leap.nvim",
      config = require("user.plugins.leap").config(),
    },
    -- {
    --   "ggandor/lightspeed.nvim",
    --   config = require("user.plugins.lightspeed").config(),
    -- },
    {
      "gelguy/wilder.nvim",
      config = require("user.plugins.wilder").config(),
      requires = { { "kyazdani42/nvim-web-devicons" }, { "romgrk/fzy-lua-native" }, { "sharkdp/fd" } },
    },
    {
      "j-hui/fidget.nvim",
      config = require("user.plugins.fidget").config(),
    },
    {
      "ThePrimeagen/harpoon",
      requires = "nvim-lua/plenary.nvim",
      config = require("user.plugins.harpoon").config(),
    },
  }
end

return M
