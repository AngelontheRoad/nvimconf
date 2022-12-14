return {
	name = "gcc build",
	builder = function()
		local file = vim.fn.expand("%:p")
		local exefile = vim.fn.expand("%:r")
		return {
			cmd = { "gcc" },
			args = { file, "-o", exefile },
			components = { { "on_output_quickfix", open = true }, "default" },
		}
	end,
	desc = "gcc generate executable",
	condition = {
		filetype = { "c" },
	},
}
