return function()
	require("completion.mason-lspconfig").setup()

	local opts = {
		capabilities = require("modules.utils").get_lsp_capabilities(),
	}

	-- Configure LSPs that are not supported by `mason.nvim` but are available in `nvim-lspconfig`.
	-- First call |vim.lsp.config()|, then |vim.lsp.enable()| (or use `register_server`, see below)
	-- to ensure the language server is properly configured and starts automatically.
	-- if vim.fn.executable("dart") == 1 then
	-- 	local _opts = require("completion.servers.dartls")
	-- 	local final_opts = vim.tbl_deep_extend("keep", _opts, opts)
	-- 	require("modules.utils").register_server("dartls", final_opts)
	-- end

	-- Start LSPs
	pcall(vim.cmd.LspStart)
end
