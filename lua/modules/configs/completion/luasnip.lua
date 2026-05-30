return function()
	local vim_path = require("core.global").vim_path
	local data_dir = require("core.global").data_dir
	local snippet_path = vim_path .. "/snips"
	local friendly_snippets_path = data_dir .. "lazy/friendly-snippets"

	require("modules.utils").load_plugin("luasnip", {
		keep_roots = true,
		link_roots = true,
		link_children = true,
		exit_roots = false,
		update_events = "TextChanged,TextChangedI",
		delete_check_events = "TextChanged,InsertLeave",
	}, false, require("luasnip").config.set_config)
	require("luasnip").log.set_loglevel("info")

	require("luasnip.loaders.from_vscode").lazy_load({
		paths = {
			snippet_path,
			friendly_snippets_path,
		},
	})
	-- I don't know why the snippets from global.json appear twice
	-- Adding line below to suppress
	require("luasnip.loaders.from_vscode").lazy_load()
	require("luasnip.loaders.from_lua").lazy_load()
	require("luasnip.loaders.from_snipmate").lazy_load()
end
