return function()
	require("modules.utils").load_plugin("bqf", {
		preview = {
			border = "single",
			wrap = true,
			winblend = 0,
		},
		filter = {
			fzf = {
				extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
			},
		},
	})
end
