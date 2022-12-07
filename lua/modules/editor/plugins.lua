local editor = {}
local conf = require("modules.editor.config")

-- for align
editor["junegunn/vim-easy-align"] = { opt = true, cmd = "EasyAlign" }
-- highlight other uses of the word under the cursor
editor["RRethy/vim-illuminate"] = {
	opt = true,
	event = "BufReadPost",
	config = conf.illuminate,
}
editor["terrortylor/nvim-comment"] = {
	opt = false,
	event = "BufReadPost",
	config = conf.nvim_comment,
}
-- for surround
editor["kylechui/nvim-surround"] = {
	opt = false,
	tag = "*", -- Use for stability; omit to completion `main` branch for the latest features
	event = "BufReadPost",
	config = conf.surrounds,
}
editor["nvim-treesitter/nvim-treesitter"] = {
	opt = true,
	run = ":TSUpdate",
	event = "BufReadPost",
	config = conf.nvim_treesitter,
}
-- treesitter move
editor["nvim-treesitter/nvim-treesitter-textobjects"] = {
	opt = true,
	after = "nvim-treesitter",
}
editor["p00f/nvim-ts-rainbow"] = {
	opt = true,
	after = "nvim-treesitter",
}
editor["JoosepAlviste/nvim-ts-context-commentstring"] = {
	opt = true,
	after = "nvim-treesitter",
}
editor["mfussenegger/nvim-ts-hint-textobject"] = {
	opt = true,
	after = "nvim-treesitter",
}
editor["windwp/nvim-ts-autotag"] = {
	opt = true,
	after = "nvim-treesitter",
	config = conf.autotag,
}
-- for wider support `%`
editor["andymass/vim-matchup"] = {
	opt = true,
	after = "nvim-treesitter",
	config = conf.matchup,
}
-- for repeated pressing `j` or `k`
editor["rainbowhxch/accelerated-jk.nvim"] = {
	opt = true,
	event = "BufWinEnter",
	config = conf.accelerated_jk,
}
-- for fFtT
editor["rhysd/clever-f.vim"] = {
	opt = true,
	event = "BufReadPost",
	config = conf.clever_f,
}
-- for :noh
editor["romainl/vim-cool"] = {
	opt = true,
	event = { "CursorMoved", "InsertEnter" },
}
-- better easymotion in neovim > 0.5
editor["phaazon/hop.nvim"] = {
	opt = true,
	branch = "v2",
	event = "BufReadPost",
	config = conf.hop,
}
editor["mfussenegger/nvim-treehopper"] = {
	opt = true,
	event = "BufReadPost",
}
-- smooth scroll
editor["karb94/neoscroll.nvim"] = {
	opt = true,
	event = "BufReadPost",
	config = conf.neoscroll,
}
-- for native terminal better support
-- useful to python
editor["akinsho/toggleterm.nvim"] = {
	opt = true,
	event = "UIEnter",
	config = conf.toggleterm,
}
-- show color of color code (hex etc.)
editor["NvChad/nvim-colorizer.lua"] = {
	opt = true,
	event = "BufReadPost",
	config = conf.nvim_colorizer,
}
-- for session file
editor["rmagatti/auto-session"] = {
	opt = true,
	cmd = { "SaveSession", "RestoreSession", "DeleteSession" },
	config = conf.auto_session,
}
-- for `jk` escape
-- editor["max397574/better-escape.nvim"] = {
-- 	opt = true,
-- 	event = "BufReadPost",
-- 	config = conf.better_escape,
-- }
editor["mfussenegger/nvim-dap"] = {
	opt = true,
	cmd = {
		"DapSetLogLevel",
		"DapShowLog",
		"DapContinue",
		"DapToggleBreakpoint",
		"DapToggleRepl",
		"DapStepOver",
		"DapStepInto",
		"DapStepOut",
		"DapTerminate",
	},
	module = "dap",
	config = conf.dap,
}
editor["mfussenegger/nvim-dap-python"] = {
	opt = true,
	after = "nvim-dap",
}
editor["rcarriga/nvim-dap-ui"] = {
	opt = true,
	after = "nvim-dap", -- Need to call setup after dap has been initialized.
	config = conf.dapui,
}
editor["nvim-telescope/telescope-dap.nvim"] = {
	opt = true,
	after = "nvim-dap",
}
-- for git
editor["tpope/vim-fugitive"] = { opt = true, cmd = { "Git", "G" } }
-- for :bdelete :bwipeout not mess up window layout
editor["famiu/bufdelete.nvim"] = {
	opt = true,
	cmd = { "Bdelete", "Bwipeout", "Bdelete!", "Bwipeout!" },
}
-- show cursor moves when jumping large distances
editor["edluffy/specs.nvim"] = {
	opt = true,
	event = "CursorMoved",
	config = conf.specs,
}
-- tab jump parentheses, quotes
editor["abecodes/tabout.nvim"] = {
	opt = true,
	event = "InsertEnter",
	wants = "nvim-treesitter",
	after = "nvim-cmp",
	config = conf.tabout,
}
-- for diff view
editor["sindrets/diffview.nvim"] = {
	opt = true,
	cmd = { "DiffviewOpen", "DiffviewClose" },
}
-- for split windows
editor["luukvbaal/stabilize.nvim"] = {
	opt = true,
	event = "BufReadPost",
}
-- make copy
editor["ibhagwan/smartyank.nvim"] = {
	opt = true,
	event = "BufReadPost",
	config = conf.smartyank,
}

-- only for fcitx5 user who uses non-English language during coding
-- editor["brglng/vim-im-select"] = {
-- 	opt = true,
-- 	event = "BufReadPost",
-- 	config = conf.imselect,
-- }

return editor
