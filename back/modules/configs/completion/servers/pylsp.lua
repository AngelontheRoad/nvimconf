-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/pylsp.lua
return {
	cmd = { "pylsp" },
	filetypes = { "python" },
	settings = {
		pylsp = {
			plugins = {
				-- Lint
				ruff = {
					enabled = true,
					select = {
						-- enable pycodestyle
						"E",
						-- enable pyflakes
						"F",
					},
					ignore = {
						-- ignore E501 (line too long)
						-- "E501",
						-- ignore F401 (imported but unused)
						-- "F401",
					},
					extendSelect = { "I" },
					severities = {
						-- Hint, Information, Warning, Error
						F403 = "I",
						F405 = "I",
						E501 = "I",
					},
				},
				flake8 = { enabled = false },
				pyflakes = { enabled = false },
				pycodestyle = { enabled = false },
				mccabe = { enabled = false },

				-- Code refactor
				rope = { enabled = true },

				-- Formatting
				black = {
					enabled = true,
					line_length = 120,
				},
				pyls_isort = { enabled = false },
				autopep8 = { enabled = false },
				yapf = { enabled = false },

				-- autocompletion
				-- jedi = {
				-- 	extra_paths = {
				-- 		"/home/chris/mambaforge/envs/sdtools/lib/python3.10/site-packages",
				-- 	},
				-- },
				-- jedi_completion = {
				-- 	cache_for = {
				-- 		"numpy",
				-- 		"pandas",
				-- 		"scipy",
				-- 		"matplotlib",
				-- 		"tensorflow",
				-- 	},
				-- },
			},
		},
	},
}