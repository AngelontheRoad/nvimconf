return function()
	require("modules.utils").load_plugin("paint", {
		highlights = {
			{
				filter = { filetype = "lua" },
				pattern = "%s*%-%-%-%s*(@%w+)",
				hl = "Constant",
			},
		},
	})
end
