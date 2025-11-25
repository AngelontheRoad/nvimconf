-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/ruff.lua
return {
	cmd = { "ruff", "server" },
	filetype = { "python" },
	root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
	single_file_support = true,
	settings = {
		init_options = {
			settings = {
				lint = {
					ignore = { "E4", "E501", "E741", "E742", "E743", "F403", "F405" },
					select = {
						-- enable: pycodestyle
						"E",
						-- enable: pyflakes
						"F",
					},
					extendSelect = {
						-- enable: isort
						"I",
					},
					-- the same line length as black
					lineLength = 88,
				},
			},
		},
	},
}
