local bind = require("keymap.bind")
local map_cr = bind.map_cr

local mappings = {
	plugins = {
		-- Plugins: render-markdown.nvim
		["n|<F1>"] = map_cr("RenderMarkdown toggle")
			:with_noremap()
			:with_silent()
			:with_desc("tool: toggle markdown preview within nvim"),
		-- Plugin render-markdown.nvim
		["n|<F12>"] = map_cr("RenderMarkdown toggle")
			:with_noremap()
			:with_silent()
			:with_desc("tooe: toggle markdown preview within nvim"),
	},
}

bind.nvim_load_mapping(mappings.plugins)
