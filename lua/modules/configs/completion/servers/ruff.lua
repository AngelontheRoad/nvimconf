return function(options)
	require("lspconfig").ruff.setup({
		on_attach = options.on_attach,
		single_file_support = true,
		filetype = { "python" },
		init_options = {
			settings = {
				-- Server settings should go here
				lineLength = 120,
				lint = {
					ignore = { "E4", "E501", "E741", "E742", "E743", "F403", "F405" },
				},
			},
		},
	})
end
