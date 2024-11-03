local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
local et = bind.escape_termcode

local plug_map = {
	-- Plugin persisted.nvim
	["n|<leader>ss"] = map_cu("SessionSave"):with_noremap():with_silent():with_desc("session: Save"),
	["n|<leader>sl"] = map_cu("SessionLoad"):with_noremap():with_silent():with_desc("session: Load current"),
	["n|<leader>sd"] = map_cu("SessionDelete"):with_noremap():with_silent():with_desc("session: Delete"),

	-- Plugin: comment.nvim
	["n|gcc"] = map_callback(function()
			return vim.v.count == 0 and et("<Plug>(comment_toggle_linewise_current)")
				or et("<Plug>(comment_toggle_linewise_count)")
		end)
		:with_silent()
		:with_noremap()
		:with_expr()
		:with_desc("edit: Toggle comment for line"),
	["n|gbc"] = map_callback(function()
			return vim.v.count == 0 and et("<Plug>(comment_toggle_blockwise_current)")
				or et("<Plug>(comment_toggle_blockwise_count)")
		end)
		:with_silent()
		:with_noremap()
		:with_expr()
		:with_desc("edit: Toggle comment for block"),
	["n|gc"] = map_cmd("<Plug>(comment_toggle_linewise)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for line with operator"),
	["n|gb"] = map_cmd("<Plug>(comment_toggle_blockwise)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for block with operator"),
	["x|gc"] = map_cmd("<Plug>(comment_toggle_linewise_visual)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for line with selection"),
	["x|gb"] = map_cmd("<Plug>(comment_toggle_blockwise_visual)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for block with selection"),

	-- Plugin: hop.nvim
	["nv|<leader>w"] = map_cmd("<Cmd>HopWordMW<CR>"):with_noremap():with_desc("jump: Goto word"),
	["nv|<leader>j"] = map_cmd("<Cmd>HopLineMW<CR>"):with_noremap():with_desc("jump: Goto line"),
	["nv|<leader>k"] = map_cmd("<Cmd>HopLineMW<CR>"):with_noremap():with_desc("jump: Goto line"),
	["nv|<leader>c"] = map_cmd("<Cmd>HopChar1MW<CR>"):with_noremap():with_desc("jump: Goto one char"),
	-- ["nv|<leader>c"] = map_cmd("<Cmd>HopChar2MW<CR>"):with_noremap():with_desc("jump: Goto two chars"),

	-- Plugin: nvim-spectre
	["n|<leader>Ss"] = map_callback(function()
			require("spectre").toggle()
		end)
		:with_silent()
		:with_noremap()
		:with_desc("editn: Toggle search & replace panel"),
	["n|<leader>Sp"] = map_callback(function()
			require("spectre").open_visual({ select_word = true })
		end)
		:with_silent()
		:with_noremap()
		:with_desc("editn: search & replace current word (project)"),
	["v|<leader>Sp"] = map_callback(function()
			require("spectre").open_visual()
		end)
		:with_silent()
		:with_noremap()
		:with_desc("edit: search & replace current word (project)"),
	["n|<leader>Sf"] = map_callback(function()
			require("spectre").open_file_search({ select_word = true })
		end)
		:with_silent()
		:with_noremap()
		:with_desc("editn: search & replace current word (file)"),

	-- Plugin: treesj
	["n|<leader>tm"] = map_cu("lua require('treesj').toggle()")
		:with_noremap()
		:with_desc("edit: Toggle node under cursor"),
	["n|<leader>tM"] = map_cu("lua require('treesj').toggle({ split = { recursive = true } })")
		:with_noremap()
		:with_desc("edit: Toggle node recursively under cursor"),

	-- Plugin: nvim-treehopper
	["o|m"] = map_cu("lua require('tsht').nodes()"):with_silent():with_desc("jump: Operate across syntax tree"),

	-- Plugin suda.vim
	["n|<C-S-s>"] = map_cu("SudaWrite"):with_silent():with_noremap():with_desc("edit: Save file using sudo"),
}

bind.nvim_load_mapping(plug_map)
