---@module [TODO:description]
---@author [TODO:description]
---@license [TODO:description]

local editor = {}

editor["olimorris/persisted.nvim"] = {
	lazy = true,
	cmd = "Persisted",
	config = require("editor.persisted"),
}
-- editor["m4xshen/autoclose.nvim"] = {
-- 	lazy = true,
-- 	event = "BufReadPost",
-- 	config = require("editor.autoclose"),
-- }
editor["folke/flash.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.flash"),
}
editor["sindrets/diffview.nvim"] = {
	lazy = true,
	cmd = { "DiffviewOpen", "DiffviewClose" },
	config = require("editor.diffview"),
}
editor["nvim-mini/mini.ai"] = {
	version = "*",
	config = require("editor.ai_textobj"),
}
editor["nvim-mini/mini.align"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.align"),
}
editor["nvim-mini/mini.cursorword"] = {
	lazy = true,
	event = { "BufReadPost", "BufAdd", "BufNewFile" },
	config = require("editor.cursorword"),
}
editor["nvim-mini/mini.surround"] = {
	lazy = true,
	event = { "BufReadPost", "BufNewFile" },
	version = false,
	config = require("editor.surround"),
}
editor["brenoprata10/nvim-highlight-colors"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.highlight-colors"),
}
editor["lambdalisue/suda.vim"] = {
	lazy = true,
	cmd = { "SudaRead", "SudaWrite" },
	init = require("editor.suda"),
}
-- editor["tpope/vim-sleuth"] = {
-- 	lazy = true,
-- 	event = { "BufNewFile", "BufReadPost", "BufFilePost" },
-- }
editor["MagicDuck/grug-far.nvim"] = {
	lazy = true,
	cmd = "GrugFar",
	config = require("editor.grug-far"),
}
----------------------------------------------------------------------
--                  :treesitter related plugins                    --
----------------------------------------------------------------------
editor["jmbuhr/otter.nvim"] = {
	lazy = true,
	ft = { "toml", "markdown", "quarto", "org", "norg" },
	dependencies = "nvim-treesitter/nvim-treesitter",
	-- config = function()
	-- 	vim.api.nvim_create_autocmd("FileType", {
	-- 		pattern = { "toml", "markdown", "quarto", "org", "norg" },
	-- 		group = vim.api.nvim_create_augroup("EmbedToml", { clear = true }),
	-- 		callback = function()
	-- 			require("otter").activate()
	-- 		end,
	-- 	})
	-- end,
}

editor["nvim-treesitter/nvim-treesitter"] = {
	lazy = false, -- nvim-ts cannot lazy load now
	branch = "main",
	build = ":TSUpdate",
	config = require("editor.treesitter"),
	dependencies = {
		-- { "mfussenegger/nvim-treehopper" },
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			branch = "main",
			config = require("editor.ts-textobjects"),
		},
		-- {
		-- 	"andymass/vim-matchup",
		-- 	init = require("editor.matchup"),
		-- },
		{
			"windwp/nvim-ts-autotag",
			config = require("editor.autotag"),
		},
		{
			"hiphish/rainbow-delimiters.nvim",
			submodules = false,
			config = require("editor.rainbow_delims"),
		},
		{
			"nvim-treesitter/nvim-treesitter-context",
			config = require("editor.ts-context"),
		},
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			config = require("editor.ts-context-commentstring"),
		},
		{
			"Wansmer/treesj",
			config = require("editor.treesj"),
		},
		{
			"danymat/neogen",
			cmd = "Neogen",
			config = require("editor.neogen"),
		},
	},
}

return editor
