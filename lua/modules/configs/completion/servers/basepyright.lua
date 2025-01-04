return function(options)
	require("lspconfig").basedpyright.setup({
		settings = {
			basedpyright = {
				disableOrganizeImports = true,
				disableTaggedHints = false,
				analysis = {
					autoSearchPaths = true,
					diagnosticMode = "workspace", -- openFilesOnly
					stubPath = vim.fs.joinpath(vim.fn.stdpath("data"), "site", "lazy", "python-type-stubs", "stubs"),
					typeCheckingMode = "recommended", -- "off", "basic", "standard", "strict", "recommended", "all"
					useLibraryCodeForTypes = true,
				},
			},
		},
	})
end
