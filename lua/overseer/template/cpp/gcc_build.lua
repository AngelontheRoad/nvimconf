return {
	name = "g++ build",
	builder = function()
		local file = vim.fn.expand("%:p")
		local exefile = vim.fn.expand("%:r")
		return {
			cmd = { "g++" },
			args = { file, "-o", exefile },
			components = { { "on_output_quickfix", open = true }, "default" },
		}
	end,
	desc = "g++ generate executable",
	condition = {
		filetype = { "cpp" },
	},
}
