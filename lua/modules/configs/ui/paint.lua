return function()
	require("modules.utils").load_plugin("paint", {
		highlights = {
			{
				filter = { filetype = "lua" },
				pattern = "%s*%-%-%-%s*(@%w+%s%w+)",
				hl = "Constant",
			},
			{
				filter = { filetype = "lua" },
				pattern = "%s*%-%-%-%s*@%w+%s(%w+)",
				hl = "NvimString",
			},
		},
	})
end
