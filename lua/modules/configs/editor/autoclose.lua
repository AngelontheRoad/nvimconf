return function()
	require("modules.utils").load_plugin("autoclose", {
		keys = {
			["("] = { escape = false, close = true, pair = "()" },
			["["] = { escape = false, close = true, pair = "[]" },
			["{"] = { escape = false, close = true, pair = "{}" },

			["<"] = { escape = true, close = true, pair = "<>", enabled_filetypes = { "rust" } },
			[">"] = { escape = true, close = false, pair = "<>" },
			[")"] = { escape = true, close = false, pair = "()" },
			["]"] = { escape = true, close = false, pair = "[]" },
			["}"] = { escape = true, close = false, pair = "{}" },

			['"'] = { escape = true, close = true, pair = '""' },
			["`"] = { escape = true, close = true, pair = "``" },
			["'"] = { escape = true, close = true, pair = "''", disabled_filetypes = { "rust" } },
			-- ["<"] = { escape = true, close = true, pair = "<>", disabled_filetypes = { "cpp", "python" } },
		},
		options = {
			disable_when_touch = false,
			disabled_filetypes = {
				"alpha",
				"bigfile",
				"checkhealth",
				"dap-repl",
				"diff",
				"help",
				"log",
				"notify",
				"NvimTree",
				"Outline",
				"qf",
				"TelescopePrompt",
				"toggleterm",
				"undotree",
				"vimwiki",
			},
		},
	})
	-- override <C-H> inoremap at this plugin
	vim.api.nvim_set_keymap("i", "<C-h>", "<Left>", { noremap = true, desc = "edit: Move cursor to left" })
end
