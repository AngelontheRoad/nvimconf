local editor = {}

editor["olimorris/persisted.nvim"] = {
	lazy = true,
	event = "BufReadPre", -- Ensure the plugin loads only when a buffer has been loaded
	config = require("editor.persisted"),
}
editor["m4xshen/autoclose.nvim"] = {
	lazy = true,
	event = "BufReadPost",
	config = require("editor.autoclose"),
}
-- NOTE: `flash.nvim` is a powerful plugin that can be used as partial or complete replacements for:
--  > `hop.nvim`,
--  > `wilder.nvim`
--  > `nvim-treehopper`
-- Considering its steep learning curve as well as backward compatibility issues...
--  > We have no plan to remove the above plugins for the time being.
-- But as usual, you can always tweak the plugin to your liking.
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
editor["echasnovski/mini.align"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.align"),
}
editor["echasnovski/mini.cursorword"] = {
	lazy = true,
	event = { "BufReadPost", "BufAdd", "BufNewFile" },
	config = require("editor.cursorword"),
}
-- editor["smoka7/hop.nvim"] = {
-- 	lazy = true,
-- 	version = "*",
-- 	event = { "CursorHold", "CursorHoldI" },
-- 	config = require("editor.hop"),
-- }
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
editor["kylechui/nvim-surround"] = {
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	lazy = true,
	event = "VeryLazy",
	config = require("editor.nvim-surround"),
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
	build = function()
		if #vim.api.nvim_list_uis() > 0 then
			vim.cmd.TSUpdate()
		end
	end,
	config = require("editor.treesitter"),
	dependencies = {
		-- { "mfussenegger/nvim-treehopper" },
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			branch = "main",
			config = require("editor.ts-textobjects"),
		},
		{
			"andymass/vim-matchup",
			init = require("editor.matchup"),
		},
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
