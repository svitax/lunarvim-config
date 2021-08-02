-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- TODO: refactor config into multiple files

-- NOTE: General
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "fennec-gruvbox"

-- NOTE: Custom keymappings
lvim.leader = "space"
-- overwrite the key-mappings provided by LunarVim for any mode, or leave it empty to keep them
-- lvim.keys.normal_mode = {
--   Page down/up
--   {'[d', '<PageUp>'},
--   {']d', '<PageDown>'},
--
--   Navigate buffers
--   {'<Tab>', ':bnext<CR>'},
--   {'<S-Tab>', ':bprevious<CR>'},
-- }

-- if you just want to augment the existing ones then use the utility function
-- require("utils").add_keymap_normal_mode({ silent = true, noremap = true }, {
require("utils.keymap").load_mode("n", {
	{ "<C-s>", ":w<cr>" },
	{ ";", "l" },
	{ "l", "h" },
	-- make Y act like D and C but for yanking
	{ "Y", "y$" },
	-- like the previous but ignores white space
	-- { "Y", "yg_"},
	-- keep cursor centered when using n(next) and N(previous)
	{ "n", "nzzzv" },
	{ "N", "Nzzzv" },
	-- keep cursor centered and in-place when joining lines with J
	{ "J", "mzJ`z" },
	-- move current line up/down
	{ "<C-M-j>", ":m .+1<cr>==" },
	{ "<C-M-k>", ":m .-2<cr>==" },
}, {
	silent = true,
	noremap = true,
})
-- require("utils").add_keymap_visual_mode({ silent = true, noremap = true }, {
require("utils.keymap").load_mode("v", {
	-- move visual selection up/down
	{ "<C-s>", ":w<cr>" },
	{ ";", "l" },
	{ "l", "h" },
	-- Move visual selection up/down
	{ "<C-M-j>", ":m '>+1<cr>gv=gv" },
	{ "<C-M-k>", ":m '<-2<cr>gv=gv" },
}, {
	silent = true,
	noremap = true,
})
-- require("utils").add_keymap_insert_mode({ silent = true, noremap = true }, {
require("utils.keymap").load_mode("i", {
	-- Undo break points (for a finer-grained undo command)
	-- should I add space to this list?
	{ ",", ",<c-g>u" },
	{ ".", ".<c-g>u" },
	{ "!", "!<c-g>u" },
	{ "?", "?<c-g>u" },
	{ "<cr>", "<cr><c-g>u" },
	-- Move current line up/down
	{ "<C-M-j>", "<Esc>:m .+1<CR>==gi" },
	{ "<C-M-k>", "<Esc>:m .-2<CR>==gi" },
}, {
	silent = true,
	noremap = true,
})
-- you can also use the native vim way directly
-- vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", { noremap = true, silent = true, expr = true })

-- NOTE: Custom config for builtin plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true

lvim.builtin.terminal.active = true
-- lvim.builtin.terminal.execs = {
-- 	{ "lazygit", "gg", "LazyGit" },
-- }

lvim.builtin.nvimtree.side = "left"
-- if i ever want to use netrw
-- lvim.builtin.nvimtree.disable_netrw = 0
-- lvim.builtin.nvimtree.hijack_netrw = 0
-- lvim.builtin.nvimtree.show_icons.git = 1

lvim.builtin.dap.active = true
lvim.builtin.dap.on_config_done = function()
	-- require("dap-install").config("python_dbg", {})
	local dap = require("dap")
	dap.adapters.python = {
		type = "executable",
		command = "python",
		args = { "-m", "debugpy.adapter" },
	}
	dap.configurations.python = {
		{
			type = "python",
			request = "launch",
			name = "Launch file",
			program = "${file}", -- This configuration will launch the current file if used.
			pythonPath = "/usr/local/bin/python3",
			-- TODO: fix python debugging resolving to conda environment
			-- pythonPath = function()
			-- 	-- TODO: the problem is my VIRTUAL_ENV variable is never set
			-- 	local cwd = vim.fn.getenv("VIRTUAL_ENV")
			-- 	if vim.fn.executable(cwd .. "/bin/python") == 1 then
			-- 		return cwd .. "/bin/python"
			-- 	elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
			-- 		return cwd .. "/.venv/bin/python"
			-- 	else
			-- 		return "/usr/local/bin/python3"
			-- 	end
			-- end,
		},
	}
end

lvim.builtin.compe.source.tabnine = { kind = " ", priority = 200, max_reslts = 6 }
lvim.builtin.compe.source.orgmode = true

-- lvim.builtin.galaxyline.active = false

-- lvim.builtin.telescope.defaults.mappings.i["<C-h>"] = require("telescope").extensions.hop.hop
local actions = require("telescope.actions")
lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
lvim.builtin.telescope.defaults.path_display.shorten = 4
lvim.builtin.telescope.defaults.sorting_strategy = "ascending"
lvim.builtin.telescope.defaults.layout_config.prompt_position = "top"
lvim.builtin.telescope.defaults.layout_config.horizontal = {
	width_padding = 0.04,
	height_padding = 0.1,
	preview_width = 0.6,
}
lvim.builtin.telescope.defaults.layout_config.vertical = {
	width_padding = 0.05,
	height_padding = 1,
	preview_height = 0.5,
}

-- NOTE: Treesitter settings
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.indent.disable = { "python" }
lvim.builtin.treesitter.matchup.enable = true

-- NOTE: Generic LSP settings
lvim.lsp.diagnostics.virtual_text = false
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- NOTE: Additional plugins
lvim.plugins = {
	-----[[------------]]-----
	---        LSP         ---
	-----]]------------[[-----
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").on_attach({
				hint_enable = false,
				handler_opts = {
					border = "single", -- double, single, shadow, none
				},
			})
		end,
		event = "InsertEnter",
	},
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
	-----[[------------]]-----
	---        Git         ---
	-----]]------------[[-----
	-- TODO waiting for diff file history (there's an issue already put up)
	{
		"sindrets/diffview.nvim",
		cmd = "DiffviewOpen",
	},
	-- {"ThePrimeagen/git-worktree.nvim"},
	-- {
	-- 	"TimUntersberger/neogit",
	-- 	requires = "nvim-lua/plenary.nvim",
	-- 	cmd = "Neogit",
	-- },
	-- {
	-- 	"tanvirtin/vgit.nvim",
	-- 	event = "BufWinEnter",
	-- 	config = function()
	-- 		require("vgit").setup({
	-- 			hunks_enabled = false,
	-- 			blames_enabled = false,
	-- 			diff_preference = "vertical",
	-- 			diff_strategy = "index",
	-- 		})
	-- 	end,
	-- },
	{
		"pwntester/octo.nvim",
		cmd = "Octo",
		config = function()
			require("octo").setup()
		end,
	},
	-----[[------------]]-----
	---        Notes       ---
	-----]]------------[[-----
	{
		"vimwiki/vimwiki",
		branch = "dev",
		config = function()
			-- vim.cmd("let g:vimwiki_list = [{'path': '~/Desktop/vimwiki/markdown', 'syntax': 'markdown', 'ext': '.md'}]")
			vim.cmd(
				"let g:vimwiki_list = [{'path': '/Users/svitax/Library/Mobile Documents/iCloud~md~obsidian/Documents/svitax', 'syntax': 'markdown', 'ext': '.md'}]"
			)
			-- vim.cmd("let g:vimwiki_list = [{'path': '~/Desktop/vimwiki', 'nested_syntaxes': {'python': 'python', 'c++': 'cpp'}}]")
			vim.g.vimwiki_global_ext = 0
			vim.g.vimwiki_markdown_link_ext = 1
			vim.g.vimwiki_folding = "expr"
			-- -- vim.g.vimwiki_ext2syntax = {}
			vim.api.nvim_set_keymap("n", "<leader>wn", "<Plug>VimwikiNextLink", { silent = true })
			vim.api.nvim_set_keymap("n", "<leader>wb", "<Plug>VimwikiPrevLink", { silent = true })
		end,
		-- event = "BufRead",
	},
	-- {
	--   'iamcco/markdown-preview.nvim',
	--   run = 'cd app && npm install',
	--   ft = 'markdown',
	-- },
	-- {"shurcooL/markdownfmt"},
	-- {
	--   'jubnzv/mdeval.nvim',
	--   config = function ()
	--     require 'mdeval'.setup()
	--   end
	-- },
	{
		"plasticboy/vim-markdown",
		ft = { "markdown", "vimwiki" },
		config = function()
			-- Vim Markdown
			vim.g.vim_markdown_folding_disabled = 0
			vim.g.vim_markdown_math = 1
			vim.g.vim_markdown_frontmatter = 1
			vim.g.vim_markdown_strikethrough = 1
			vim.g.vim_markdown_conceal = 3
			-- vim.cmd("set conceallevel=2")
			vim.g.vim_markdown_follow_anchor = 1
			vim.g.vim_markdown_no_extensions_in_markdown = 1
			vim.g.vim_markdown_autowrite = 1
			-- vim.cmd("let g:markdown_fenced_languages = ['python']")
		end,
	},
	{
		"kristijanhusak/orgmode.nvim",
		config = function()
			require("orgmode").setup({})
		end,
		event = "BufRead",
	},
	-----[[------------]]-----
	---       Editing      ---
	-----]]------------[[-----
	-- {
	--   "blackCauldron7/surround.nvim"
	-- },
	-- {
	--   'mizlan/iswap.nvim'
	-- },
	-- {
	--   'code-biscuits/nvim-biscuits'
	-- },
	{
		"mg979/vim-visual-multi",
		event = "CursorMoved",
	},
	-----[[------------]]-----
	---     Navigation     ---
	-----]]------------[[-----
	{
		"ggandor/lightspeed.nvim",
		event = "BufRead",
	},
	{
		"karb94/neoscroll.nvim",
		event = "BufRead",
		config = function()
			require("neoscroll").setup()
		end,
	},
	{
		"abecodes/tabout.nvim",
		event = "InsertEnter",
		config = function()
			require("tabout").setup({
				completion = false,
				tabkey = "<M-Tab>",
				backwards_tabkey = "<M-S-Tab>",
				-- ignore_beginning = true, -- if the cursor is at the beginning of a filled element it will rather tab out than shift the content
			})
		end,
		after = { "nvim-compe" },
	},
	-- TODO not working
	-- {
	-- 	"nvim-telescope/telescope-hop.nvim",
	-- 	after = "telescope.nvim",
	-- 	config = function()
	-- 		require("telescope").load_extension("hop")
	-- 	end,
	-- },
	-- lsp-rooter vs vim-rooter?
	{
		"ahmedkhalf/lsp-rooter.nvim",
		event = "BufRead",
	},
	{
		"numToStr/Navigator.nvim",
		event = "BufWinEnter",
		config = function()
			require("Navigator").setup()
			vim.api.nvim_set_keymap("n", "<C-l>", "<cmd>lua require('Navigator').left()<CR>", { silent = true })
			vim.api.nvim_set_keymap("n", "<C-j>", "<cmd>lua require('Navigator').down()<CR>", { silent = true })
			vim.api.nvim_set_keymap("n", "<C-k>", "<cmd>lua require('Navigator').up()<CR>", { silent = true })
			vim.api.nvim_set_keymap("n", "<C-h>", "<cmd>lua require('Navigator').right()<CR>", { silent = true })
		end,
	},
	{
		"nvim-telescope/telescope-project.nvim",
		event = "BufWinEnter",
		config = function()
			require("telescope").load_extension("project")
		end,
	},
	{
		"andymass/vim-matchup",
		event = "CursorMoved",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
			-- vim.g.matchup_matchparen_enabled = 0
		end,
	},
	{
		"kevinhwang91/rnvimr",
		cmd = "RnvimrToggle",
		config = function()
			-- " Make Ranger replace Netrw and be the file explorer
			vim.g.rnvimr_enable_ex = 1
			-- " Make Ranger to be hidden after picking a file
			vim.g.rnvimr_enable_picker = 1
			-- " Disable a border for floating window
			-- vim.g.rnvimr_draw_border = 0
			-- " Hide the files included in gitignore
			-- vim.g.rnvimr_hide_gitignore = 1
			-- " Make Neovim wipe the buffers corresponding to the files deleted by Ranger
			vim.g.rnvimr_enable_bw = 1
			-- " Add a shadow window, value is equal to 100 will disable shadow
			vim.g.rnvimr_shadow_winblend = 70
			-- " Draw border with both
			-- vim.g.rnvimr_ranger_cmd = 'ranger --cmd="set draw_borders both"'
			vim.g.rnvimr_ranger_cmd = "/Users/svitax/.miniconda/envs/ranger/bin/ranger"
		end,
	},
	-----[[------------]]-----
	---      Sessions      ---
	-----]]------------[[-----
	-- {"rmagatti/auto-session"},
	-- {"rmagatti/session-lens"},
	{
		"ethanholz/nvim-lastplace",
		event = "BufRead",
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = {
					"gitcommit",
					"gitrebase",
					"svn",
					"hgcommit",
				},
				lastplace_open_folds = true,
			})
		end,
	},
	-----[[------------]]-----
	---        Web         ---
	-----]]------------[[-----
	{
		"turbio/bracey.vim",
		event = "BufRead",
		run = "npm install --prefix server",
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
	},
	-----[[------------]]-----
	---       Debug        ---
	-----]]------------[[-----
	-- { 'michaelb/sniprun', run = 'bash ./install.sh'},
	{
		"rcarriga/nvim-dap-ui",
		config = function()
			require("dapui").setup()
		end,
		requires = { "mfussenegger/nvim-dap" },
		ft = "python",
	},
	-----[[------------]]-----
	---       Colors       ---
	-----]]------------[[-----
	{
		"svitax/fennec-gruvbox.nvim",
		requires = { "rktjmp/lush.nvim" },
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = "BufRead",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = function()
			require("todo-comments").setup({})
		end,
	},
	-----[[------------]]-----
	---     Completion     ---
	-----]]------------[[-----
	-- {
	--   "tamago324/compe-zsh"
	-- },
	{
		"tzachar/compe-tabnine",
		run = "./install.sh",
		requires = "hrsh7th/nvim-compe",
		event = "InsertEnter",
	},
	-----[[------------]]-----
	---       Extras       ---
	-----]]------------[[-----
	{
		"ianding1/leetcode.vim",
		config = function()
			vim.g.leetcode_browser = "firefox"
			vim.g.leetcode_solution_filetype = "python3"
			vim.g.leetcode_hide_topics = 1
			vim.g.leetcode_hide_companies = 1
		end,
		cmd = "LeetCodeList",
	},
	-- {
	--   'simrat39/symbols-outline.nvim'
	-- },
	-- {
	--   'kristijanhusak/vim-dadbod-ui'
	-- },
	-- {
	--   'tpope/vim-dadbod'
	-- },
}

-- NOTE: Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
	{ "BufWinEnter", "*.md", "set nospell" },
	-- { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
}

-- NOTE: Overide bindings for WhichKey
-- lvim.builtin.which_key.mappings["h"] = { "<cmd>Telescope find_files<CR>", "Find File" }
lvim.builtin.which_key.mappings["b"]["b"] = { "<cmd>Telescope buffers<CR>", "Switch buffer" }
lvim.builtin.which_key.mappings["b"]["d"] = { "<cmd>BufferClose!<CR>", "Delete buffer" }
lvim.builtin.which_key.mappings["b"]["h"] = { "<cmd>new<CR>", "New horizontal buffer" }
lvim.builtin.which_key.mappings["b"]["l"] = { "<cmd>BufferCloseBuffersLeft<cr>", "Close all buffers to the left" }
lvim.builtin.which_key.mappings["b"]["v"] = { ":vnew<cr>", "New vertical buffer" }
lvim.builtin.which_key.mappings["b"][";"] = { "<cmd>BufferCloseBuffersRight<cr>", "Close all buffers to the right" }

lvim.builtin.which_key.mappings["dU"] = { "<cmd>lua require('dapui').toggle()<cr>", "Toggle debug UI" }
lvim.builtin.which_key.mappings["de"] = { "<cmd>lua require('dapui').eval()<cr>", "Eval" }
lvim.builtin.which_key.mappings["dq"] = { "<cmd>lua require'dap'.close()<cr>", "Quit" }

-- lvim.builtin.which_key.mappings["g"]["b"] = { ":VGit buffer_preview<CR>", "Diff current buffer" }
-- lvim.builtin.which_key.mappings["g"]["h"] = { ":VGit buffer_history<cr>", "Diff buffer history" }
lvim.builtin.which_key.mappings["g"]["i"] = { "<cmd>Octo issue list<cr>", "GitHub issues" }
lvim.builtin.which_key.mappings["g"]["P"] = { "<cmd>Octo pr list<cr>", "GitHub pull requests" }
lvim.builtin.which_key.mappings["g"]["l"] = { "<cmd>lua require'gitsigns'.blame_line(true)<cr>", "Blame message" }
lvim.builtin.which_key.mappings["g"]["d"] = { "<cmd>DiffviewOpen<cr>", "View diffs" }
lvim.builtin.which_key.mappings["g"]["D"] = { "<cmd>DiffviewClose<cr>", "Close diff view" }

lvim.builtin.which_key.mappings["l"]["d"] = {
	"<cmd>TroubleToggle lsp_document_diagnostics<cr>",
	"List document diagnostics",
}
lvim.builtin.which_key.mappings["l"]["D"] = {
	"<cmd>TroubleToggle lsp_definitions<cr>",
	"List definitions",
}
lvim.builtin.which_key.mappings["l"]["R"] = {
	"<cmd>TroubleToggle lsp_references<cr>",
	"List references",
}
lvim.builtin.which_key.mappings["l"]["w"] = {
	"<cmd>TroubleToggle lsp_workspace_diagnostics<cr>",
	"List workspace diagnostics",
}

lvim.builtin.which_key.mappings["r"] = { "<cmd>RnvimrToggle<cr>", "Ranger" }

lvim.builtin.which_key.mappings["s"]["n"] = {
	"<cmd>lua require('telescope.builtin').find_files({cwd = '/Users/svitax/Library/Mobile Documents/iCloud~md~obsidian/Documents/svitax'})<CR>",
	"Search Obsidian notes",
}
lvim.builtin.which_key.mappings["s"]["p"] = { "<cmd>Telescope project<cr>", "Search project" }
lvim.builtin.which_key.mappings["s"]["T"] = { "<cmd>TodoTrouble<cr>", "Search todos" }

lvim.builtin.which_key.mappings["o"] = {
	name = "+Open",
	w = { "<cmd>Bracey<cr>", "Web server with live reload" },
}

lvim.builtin.which_key.mappings["w"] = {
	name = "+Windows",
	d = { "<cmd>close<CR>", "Delete current window" },
	D = { "<cmd>only<CR>", "Delete all other windows" },
	h = { "<cmd>split<CR>", "Split window horizontally" },
	j = { "<C-w>j<cr>", "Move to window below" },
	k = { "<C-w>k<cr>", "Move to window above" },
	l = { "<C-w>h<cr>", "Move to left window" },
	v = { "<cmd>vsplit<CR>", "Split window vertically" },
	[";"] = { "<C-w>l<cr>", "Move to right window" },
}