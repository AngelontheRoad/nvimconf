local tool = {}

tool["Bekaboo/dropbar.nvim"] = {
	lazy = false,
	config = require("tool.dropbar"),
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
}
tool["stevearc/oil.nvim"] = {
	lazy = false,
	config = require("tool.oil"),
	dependencies = { "nvim-tree/nvim-web-devicons" },
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
--                          AI Plugins                              --
----------------------------------------------------------------------
-- completion["yetone/avante.nvim"] = {
-- 	event = "VeryLazy",
-- 	lazy = true,
-- 	version = false,
-- 	build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
-- 		or "make",
-- 	config = require("completion.avante"),
-- 	dependencies = {
-- 		"folke/snacks.nvim",
-- 		"nvim-lua/plenary.nvim",
-- 		"MunifTanjim/nui.nvim",
-- 		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
-- 		{
-- 			-- support for image pasting
-- 			"HakonHarnes/img-clip.nvim",
-- 			event = "VeryLazy",
-- 			opts = {
-- 				-- recommended settings
-- 				default = {
-- 					embed_image_as_base64 = false,
-- 					prompt_for_file_name = false,
-- 					drag_and_drop = {
-- 						insert_mode = true,
-- 					},
-- 					-- required for Windows users
-- 					use_absolute_path = true,
-- 				},
-- 			},
-- 		},
-- 		"MeanderingProgrammer/render-markdown.nvim",
-- 	},
-- }

----------------------------------------------------------------------
--                         Git Plugins                              --
----------------------------------------------------------------------
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
tool["tpope/vim-fugitive"] = {
	lazy = true,
	cmd = { "Git", "G" },
}

----------------------------------------------------------------------
--                         Multi tasks                              --
----------------------------------------------------------------------
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

----------------------------------------------------------------------
--                        Jupyter Plugins                           --
----------------------------------------------------------------------
tool["benlubas/molten-nvim"] = {
	lazy = true,
	cond = (vim.fn.has("wsl") ~= "0"),
	version = "^1.0.0",
	ft = { "python", "markdown" },
	cmd = { "MoltenInfo", "MoltenInit" },
	build = ":UpdateRemotePlugins",
	init = require("tool.molten"),
	dependencies = {
		{
			"3rd/image.nvim",
			config = require("tool.image"),
		},
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
