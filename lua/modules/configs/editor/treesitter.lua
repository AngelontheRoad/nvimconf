return vim.schedule_wrap(function()
	vim.api.nvim_set_option_value("indentexpr", "v:lua.require'nvim-treesitter'.indentexpr()", {})
	require("modules.utils").load_plugin("nvim-treesitter", {})
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "*",
		desc = "Start treesitter for installed parsers",
		callback = function(args)
			local ft = vim.bo[args.buf].filetype
			local lang = vim.treesitter.language.get_lang(ft) or ft
			if require("core.settings").treesitter_deps[lang] then
				pcall(vim.treesitter.start, args.buf, lang)
			end
		end,
	})
	local parsers = vim.tbl_keys(require("core.settings").treesitter_deps)
	table.sort(parsers)
	require("nvim-treesitter").install(parsers)
end)
