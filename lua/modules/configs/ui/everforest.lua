return function()
	vim.g.everforest_background = "medium"
	vim.g.everforest_enable_italic = 1
	vim.g.everforest_disable_italic_comment = 1
	vim.g.everforest_show_eob = 1
	vim.g.everforest_better_performance = 1
	vim.g.everforest_transparent_background = require("core.settings").transparent_background
	vim.g.everforest_dim_inactive_window = 1
end
