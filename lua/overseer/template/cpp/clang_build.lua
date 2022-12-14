return {
	name = "clang++ build",
	builder = function()
		local file = vim.fn.expand("%:p")
		local exefile = vim.fn.expand("%:r")
		return {
			cmd = { "clang++" },
			args = { file, "-o", exefile },
			components = { { "on_output_quickfix", open = true }, "default" },
		}
	end,
	desc = "clang++ generate executable",
	condition = {
		filetype = { "cpp" },
	},
}
