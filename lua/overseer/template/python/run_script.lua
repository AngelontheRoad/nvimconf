return {
	name = "run script",
	builder = function()
		local file = vim.fn.expand("%:p")
		local cmd = { file }
		if vim.bo.filetype == "python" then
			cmd = { "python", file }
		end
		return {
			cmd = cmd,
			name = "run script",
			components = {
				{ "on_output_quickfix", set_diagnostics = true },
				"on_result_diagnostics",
				"default",
			},
		}
	end,
	condition = {
		filetype = { "c", "python" },
	},
}
