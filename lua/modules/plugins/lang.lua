local lang = {}

lang["kevinhwang91/nvim-bqf"] = {
	lazy = true,
	ft = "qf",
	config = require("lang.bqf"),
	dependencies = {
		{ "junegunn/fzf", build = ":call fzf#install()" },
	},
}
lang["ray-x/go.nvim"] = {
	lazy = true,
	ft = { "go", "gomod", "gosum" },
	build = ":GoInstallBinaries",
	config = require("lang.go"),
	dependencies = "ray-x/guihua.lua",
}
lang["iamcco/markdown-preview.nvim"] = {
	lazy = true,
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = "markdown",
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
}
lang["MeanderingProgrammer/render-markdown.nvim"] = {
	ft = { "markdown", "Avante" },
	opts = {
		file_types = { "markdown", "Avante" },
	},
	config = require("lang.render-markdown"),
}
-- lang["mrcjkb/rustaceanvim"] = {
-- 	lazy = true,
-- 	ft = "rust",
-- 	version = "*",
-- 	init = require("lang.rust"),
-- 	dependencies = "nvim-lua/plenary.nvim",
-- }
-- lang["Saecki/crates.nvim"] = {
-- 	lazy = true,
-- 	event = "BufReadPost Cargo.toml",
-- 	config = require("lang.crates"),
-- 	dependencies = "nvim-lua/plenary.nvim",
-- }

lang["kawre/leetcode.nvim"] = {
	lazy = vim.fn.argv(0, -1) ~= "leetcode.nvim",
	opts = {
		arg = "leetcode.nvim",
		cn = { enabled = true },
		picker = { provider = "snacks-picker" },
	},
}

return lang
