local on_attach = function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	-- Disable hover in favor of Pyright
	client.server_capabilities.hoverProvider = false
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

return function(options)
	require("lspconfig").ruff_lsp.setup({
		on_attach = on_attach,
		init_options = {
			settings = {
				-- path = ruff,
				-- Any extra CLI arguments for `ruff` go here.
				args = { "--ignore", "E501,F403,F405" },
			},
		},
	})
end
