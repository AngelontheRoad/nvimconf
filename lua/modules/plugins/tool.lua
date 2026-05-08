local tool = {}

tool["aaronhallaert/advanced-git-search.nvim"] = {
	lazy = true,
	cmd = { "AdvancedGitSearch" },
	config = function()
		require("advanced_git_search.snacks").setup({
			diff_plugin = "diffview",
			git_flags = { "-c", "delta.side-by-side=true" },
			entry_default_author_or_date = "author",
		})
	end,
	dependencies = {
		"tpope/vim-rhubarb",
		"tpope/vim-fugitive",
		"sindrets/diffview.nvim",
	},
}
tool["Bekaboo/dropbar.nvim"] = {
	lazy = false,
	config = require("tool.dropbar"),
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
}
tool["benlubas/molten-nvim"] = {
	lazy = true,
	cond = (vim.fn.has("wsl") ~= "0"),
	version = "^1.0.0",
	ft = { "python", "markdown" },
	-- cmd = { "MoltenInfo", "MoltenInit" },
	build = ":UpdateRemotePlugins",
	init = require("tool.molten"),
	-- use snacks instead
}
tool["stevearc/oil.nvim"] = {
	lazy = false,
	config = require("tool.oil"),
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
tool["stevearc/overseer.nvim"] = {
	lazy = true,
	cmd = {
		"OverseerRun",
		"OverseerToggle",
		"OverseerBuild",
		"OverseerInfo",
		"OverseerClose",
		"OverseerOpen",
		"OverseerTaskAction",
		"OverseerQuickAction",
	},
	config = require("tool.overseer"),
}
tool["ibhagwan/smartyank.nvim"] = {
	lazy = true,
	event = "BufReadPost",
	config = require("tool.smartyank"),
}
tool["folke/snacks.nvim"] = {
	priority = 1000,
	lazy = false,
	config = require("editor.snacks"),
}
tool["michaelb/sniprun"] = {
	lazy = true,
	cond = not (vim.uv.os_uname().sysname == "Windows_NT"),
	-- If you see an error about a missing SnipRun executable,
	-- run `bash ./install.sh` inside `~/.local/share/nvim/site/lazy/sniprun/`.
	build = "bash ./install.sh",
	cmd = { "SnipRun", "SnipReset", "SnipInfo" },
	config = require("tool.sniprun"),
}
tool["folke/trouble.nvim"] = {
	lazy = true,
	cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
	config = require("tool.trouble"),
}
tool["tpope/vim-fugitive"] = {
	lazy = true,
	cmd = { "Git", "G" },
}
tool["folke/which-key.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("tool.which-key"),
}
tool["mikavilpas/yazi.nvim"] = {
	lazy = true,
	event = "VeryLazy",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
	},
}

----------------------------------------------------------------------
--                           DAP Plugins                            --
----------------------------------------------------------------------
tool["mfussenegger/nvim-dap"] = {
	lazy = true,
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
	config = require("tool.dap"),
	dependencies = {
		{ "jay-babu/mason-nvim-dap.nvim" },
		{
			"rcarriga/nvim-dap-ui",
			dependencies = "nvim-neotest/nvim-nio",
			config = require("tool.dap.dapui"),
		},
	},
}

return tool
