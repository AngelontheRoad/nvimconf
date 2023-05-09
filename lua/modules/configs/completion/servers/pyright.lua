return function(options)
	require("lspconfig").pyright.setup({
		on_attach = function(client, _)
			client.server_capabilities.codeActionProvider = false
		end,
		capabilities = (function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
			return capabilities
		end)(),
		settings = {
			python = {
				analysis = {
					useLibraryCodeForTypes = true,
					diagnosticSeverityOverrides = {
						reportUnusedVariable = "warning", -- or anything
					},
					typeCheckingMode = "basic",
				},
			},
		},
	})
end
