local dap = require("dap")

local function isempty(s)
	return s == nil or s == ""
end

dap.adapters.python = {
	-- for help https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt
	type = "executable",
	command = "/home/chris/mambaforge/bin/python",
	args = { "-m", "debugpy.adapter" },
}
dap.configurations.python = {
	{
		-- The first three options are required by nvim-dap
		type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = "launch",
		name = "Launch file",
		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

		program = "${file}", -- This configuration will launch the current file if used.
		pythonPath = function()
			if vim.fn.executable("/home/chris/mambaforge/bin/python") then
				return "/home/chris/mambaforge/bin/python"
			else
				return "/home/chris/anaconda3/bin/python"
			end
		end,
	},
}

-- NOTE: for people using venv
-- pythonPath = function()
-- 	-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
-- 	-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
-- 	-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
-- 	local cwd, venv = vim.fn.getcwd(), os.getenv("VIRTUAL_ENV")
-- 	if venv and vim.fn.executable(venv .. "/bin/python") == 1 then
-- 		return venv .. "/bin/python"
-- 	elseif vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
-- 		return cwd .. "/venv/bin/python"
-- 	elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
-- 		return cwd .. "/.venv/bin/python"
-- 	else
-- 		return "python"
-- 	end
-- end,