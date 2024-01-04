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
			disabled_filetypes = { "big_file_disabled_ft" },
			disable_when_touch = false,
		},
	})
	-- override <C-H> inoremap at this plugin
	vim.api.nvim_set_keymap("i", "<C-h>", "<Left>", { noremap = true, desc = "edit: Move cursor to left" })
end
