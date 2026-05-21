local completion = {}
completion["Wansmer/symbol-usage.nvim"] = {
	lazy = true,
	event = "LspAttach",
	config = function()
		require("symbol-usage").setup()
		vim.api.nvim_create_user_command("E", function()
			require("symbol-usage").refresh()
		end, {})
	end,
}
completion["mason-org/mason.nvim"] = {
	lazy = true,
	cmd = {
		"Mason",
		"MasonInstall",
		"MasonUninstall",
		"MasonUninstallAll",
		"MasonUpdate",
		"MasonLog",
	},
	config = require("completion.mason").setup,
}
completion["neovim/nvim-lspconfig"] = {
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = require("completion.lsp"),
	dependencies = {
		{ "mason-org/mason.nvim" },
		{ "mason-org/mason-lspconfig.nvim" },
		{ "b0o/schemastore.nvim" },
	},
}
completion["nvimdev/lspsaga.nvim"] = {
	lazy = true,
	event = "LspAttach",
	config = require("completion.lspsaga"),
	dependencies = "nvim-tree/nvim-web-devicons",
}
completion["rachartier/tiny-inline-diagnostic.nvim"] = {
	lazy = true,
	event = "VeryLazy",
	priority = 1000,
	config = require("completion.tiny-inline-diagnostic"),
}
completion["stevearc/conform.nvim"] = {
	lazy = true,
	event = "BufWritePre",
	cmd = { "ConformInfo", "Format", "FormatToggle", "FormatterToggleFt" },
	config = require("completion.conform"),
}
completion["mfussenegger/nvim-lint"] = {
	lazy = true,
	event = { "BufWritePost", "BufReadPost" },
	config = require("completion.nvim-lint"),
}

completion["saghen/blink.cmp"] = {
	lazy = true,
	event = { "VeryLazy", "InsertEnter", "CmdlineEnter" },
	config = require("completion.blink"),
	build = function()
		-- build the fuzzy matcher, wait up to 60 seconds
		-- you can use `gb` in `:Lazy` to rebuild the plugin as needed
		require("blink.cmp").build():wait(60000)
	end,
	version = "*",
	dependencies = {
		{ "saghen/blink.lib" },
		{
			"L3MON4D3/LuaSnip",
			build = "make install_jsregexp",
			config = require("completion.luasnip"),
			dependencies = "rafamadriz/friendly-snippets",
		},
		"mikavilpas/blink-ripgrep.nvim",
		"bydlw98/blink-cmp-env",
		"disrupted/blink-cmp-conventional-commits",
		"xzbdmw/colorful-menu.nvim",
	},
	opts_extend = { "sources.default" },
}

-- Adding *nvim config dir*, *nvim runtime dir*, *all plugin dir(with /lua dir)* to get
-- hover docs and function signatures, but it takes too much time to load all dirs, use it if needed.
completion["folke/lazydev.nvim"] = {
	lazy = true,
	ft = "lua",
	config = require("completion.lazydev"),
}

return completion
