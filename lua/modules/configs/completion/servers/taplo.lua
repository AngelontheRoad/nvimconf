return function(options)
	require("lspconfig").taplo.setup({
		on_attach = options.on_attach,
		single_file_support = true,
	})
end
