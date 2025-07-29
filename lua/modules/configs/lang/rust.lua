return function()
	vim.g.rustaceanvim = {
		dap = {
			adapter = false,
			configuration = false,
			autoload_configurations = false,
		}, -- DAP configuration
		tools = {
			executor = require("rustaceanvim.executors").toggleterm,
			reload_workspace_from_cargo_toml = true,
		},
		server = { standalone = true },
	}
end
