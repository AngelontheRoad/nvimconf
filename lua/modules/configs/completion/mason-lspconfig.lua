local M = {}

M.setup = function()
	local diagnostics_virtual_text = require("core.settings").diagnostics_virtual_text
	local diagnostics_virtual_lines = require("core.settings").diagnostics_virtual_lines
	local diagnostics_level = require("core.settings").diagnostics_level

	local nvim_lsp = require("lspconfig")
	local mason_lspconfig = require("mason-lspconfig")
	require("lspconfig.ui.windows").default_options.border = "rounded"

	require("modules.utils").load_plugin("mason-lspconfig", {
		ensure_installed = require("core.settings").lsp_deps,
	})

	vim.diagnostic.config({
		signs = true,
		underline = true,
		virtual_text = diagnostics_virtual_text and {
			severity = {
				min = vim.diagnostic.severity[diagnostics_level],
			},
		} or false,
		virtual_lines = diagnostics_virtual_lines and {
			severity = {
				min = vim.diagnostic.severity[diagnostics_level],
			},
		} or false,
		-- set update_in_insert to false because it was enabled by lspsaga
		update_in_insert = false,
	})

	local opts = {
		capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities()
		),
	}
	---A handler to setup all servers defined under `completion/servers/*.lua`
	---@param lsp_name string
	local function mason_lsp_handler(lsp_name)
		local ok, custom_handler = pcall(require, "completion.servers." .. lsp_name)
		if not ok then
			-- Default to use factory config for server(s) that doesn't include a spec
			nvim_lsp[lsp_name].setup(opts)
			return
		elseif type(custom_handler) == "function" then
			--- Case where language server requires its own setup
			--- Make sure to call require("lspconfig")[lsp_name].setup() in the function
			--- See `clangd.lua` for example.
			custom_handler(opts)
		elseif type(custom_handler) == "table" then
			nvim_lsp[lsp_name].setup(vim.tbl_deep_extend("force", opts, custom_handler))
		else
			vim.notify(
				string.format(
					"Failed to setup [%s].\n\nServer definition under `completion/servers` must return\neither a fun(opts) or a table (got '%s' instead)",
					lsp_name,
					type(custom_handler)
				),
				vim.log.levels.ERROR,
				{ title = "nvim-lspconfig" }
			)
		end
	end

	mason_lspconfig.setup_handlers({ mason_lsp_handler })
end

return M
