return {
	name = "g++ build",
	builder = function()
		-- Full path to current file (see :help expand())
		local file = vim.fn.expand("%:p")
		local exe_file = vim.fn.expand("%:r")
		return {
			cmd = { "g++" },
			args = { file, "-o", exe_file },
			components = { { "on_output_quickfix", open = true }, "default" },
		}
	end,
	condition = {
		filetype = { "cpp" },
	},
	callback = function(search)
		print(vim.inspect(search))
		return true
	end,
}
