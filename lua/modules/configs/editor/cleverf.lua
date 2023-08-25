return function()
	vim.api.nvim_set_hl(
		0,
		"CleverChar",
		{ underline = true, bold = true, fg = "Orange", bg = "NONE", ctermfg = "Red", ctermbg = "NONE" }
	)
	vim.g.clever_f_mark_char_color = "CleverChar"
	vim.g.clever_f_mark_direct_color = "CleverChar"
	vim.g.clever_f_smart_case = 1
	vim.g.clever_f_mark_direct = true

	require("modules.utils").load_plugin("cleverf", nil, true)
end
