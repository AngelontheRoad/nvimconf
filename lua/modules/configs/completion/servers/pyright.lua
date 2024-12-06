return function(options)
	require("lspconfig").pyright.setup({
		on_attach = function(client, _)
			client.server_capabilities.codeActionProvider = false
		end,
		capabilities = (function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 } -- 2 means deprecated, 1 means unnecessary
			return capabilities
		end)(),
		settings = {
			pyright = {
				autoImportCompletion = true,
			},
			python = {
				analysis = {
					autoSearchPaths = true,
					typeCheckingMode = "off",
					useLibraryCodeForTypes = true,
					diagnosticMode = "openFilesOnly",
					diagnosticSeverityOverrides = {
						reportUnusedVariable = "warning", -- or anything
					},
				},
			},
		},
	})
end
