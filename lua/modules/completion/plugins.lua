local completion = {}
local conf = require("modules.completion.config")

-- lsp manager
completion["neovim/nvim-lspconfig"] = {
	opt = true,
	event = "BufReadPre",
	config = conf.nvim_lsp,
}
completion["creativenull/efmls-configs-nvim"] = {
	opt = false,
	requires = "neovim/nvim-lspconfig",
}
completion["williamboman/mason.nvim"] = {
	opt = false,
	requires = {
		{
			"williamboman/mason-lspconfig.nvim",
		},
		{
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			config = conf.mason_install,
		},
	},
}
completion["glepnir/lspsaga.nvim"] = {
	opt = true,
	event = "LspAttach",
	config = conf.lspsaga,
}
completion["ray-x/lsp_signature.nvim"] = {
	opt = true,
	after = "nvim-lspconfig",
}
completion["hrsh7th/nvim-cmp"] = {
	config = conf.cmp,
	event = "InsertEnter",
	requires = {
		{ "onsails/lspkind.nvim" },
		{ "lukas-reineke/cmp-under-comparator" },
		{ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
		{ "hrsh7th/cmp-nvim-lsp", after = "cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lua", after = "cmp-nvim-lsp" },
		{ "hrsh7th/cmp-path", after = "cmp-nvim-lua" },
		{ "f3fora/cmp-spell", after = "cmp-path" },
		{ "hrsh7th/cmp-buffer", after = "cmp-spell" },
		{ "kdheepak/cmp-latex-symbols", after = "cmp-buffer" },
		{ "hrsh7th/cmp-cmdline", after = "cmp-latex-symbols" },
	},
}
-- snippets
completion["L3MON4D3/LuaSnip"] = {
	after = "nvim-cmp",
	config = conf.luasnip,
	requires = "rafamadriz/friendly-snippets",
}
-- autopairs
completion["windwp/nvim-autopairs"] = {
	after = "nvim-cmp",
	config = conf.autopairs,
}

-- copilot
-- completion["zbirenbaum/copilot.lua"] = {
-- 	event = "VimEnter",
-- 	config = conf.copilot,
-- }
-- completion['zbirenbaum/copilot-cmp'] = {
-- 	after = 'copilot.lua',
-- 	config = function()
-- 	    require('copilot_cmp').setup()
-- 	end,
-- }
-- <<< complete plugins end <<<

return completion
