local on_attach = function(client, bufnr)
	-- Disable hover in favor of Pyright
	client.server_capabilities.hoverProvider = false
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

return function(options)
	require("lspconfig").ruff_lsp.setup({
		on_attach = on_attach,
		init_options = {
			settings = {
				-- Any extra CLI arguments for `ruff` go here.
				args = { "--ignore", "E203, E501, F403, F405, W292" },
			},
		},
	})
end
