---@diagnostic disable: undefined-global
local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
local helpers = require("keymap.helpers")

local ts_to_select = require("nvim-treesitter-textobjects.select")
local ts_to_swap = require("nvim-treesitter-textobjects.swap")
local ts_to_move = require("nvim-treesitter-textobjects.move")
local ts_to_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

local mappings = {
	builtins = {
		-- Builtins: Save & Quit
		["n|<C-s>"] = map_cu("write"):with_noremap():with_silent():with_desc("edit: Save file"),

		-- Builtin: Insert mode
		["i|<C-u>"] = map_cmd("<C-G>u<C-U>"):with_noremap():with_desc("edit: Delete previous block"),
		["i|<C-a>"] = map_cmd("<ESC>^i"):with_noremap():with_desc("edit: Move cursor to line start"),
		["i|<C-e>"] = map_cmd("<END>"):with_noremap():with_desc("edit: Move cursor to line end"),
		["i|<C-s>"] = map_cmd("<Esc>:w<CR>"):with_desc("edit: Save file"),
		["i|<C-b>"] = map_cmd("<Left>"):with_noremap():with_desc("edit: Move cursor to left"),
		["i|<C-f>"] = map_cmd("<Right>"):with_noremap():with_desc("edit: Move cursor to right"),
		["i|<A-b>"] = map_cmd("<ESC>bi"):with_noremap():with_desc("edit: Move cursor to left"),
		["i|<A-f>"] = map_cmd("<ESC>lwi"):with_noremap():with_desc("edit: Move cursor to right"),
		["i|<C-h>"] = map_cmd("<Left>"):with_noremap():with_desc("edit: Move cursor to left"),
		["i|<C-l>"] = map_cmd("<Right>"):with_noremap():with_desc("edit: Move cursor to right"),
		["i|<C-j>"] = map_cmd("<Down>"):with_noremap():with_desc("edit: Move cursor to down"),
		["i|<C-k>"] = map_cmd("<Up>"):with_noremap():with_desc("edit: Move cursor to up"),

		-- Builtin: Command mode
		["c|<C-b>"] = map_cmd("<Left>"):with_noremap():with_desc("edit: Left"),
		["c|<C-f>"] = map_cmd("<Right>"):with_noremap():with_desc("edit: Right"),
		["c|<A-b>"] = map_cmd("<C-Left>"):with_noremap():with_desc("edit: Left"),
		["c|<A-f>"] = map_cmd("<C-Right>"):with_noremap():with_desc("edit: Right"),
		["c|<C-a>"] = map_cmd("<Home>"):with_noremap():with_desc("edit: Home"),
		["c|<C-e>"] = map_cmd("<End>"):with_noremap():with_desc("edit: End"),
		["c|<C-d>"] = map_cmd("<Del>"):with_noremap():with_desc("edit: Delete"),
		["c|<C-h>"] = map_cmd("<BS>"):with_noremap():with_desc("edit: Backspace"),
		["c|<C-t>"] = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]])
			:with_noremap()
			:with_desc("edit: Complete path of current file"),

		-- Builtin: Visual mode
		["v|J"] = map_cmd(":m '>+1<CR>gv=gv"):with_desc("edit: Move this line down"),
		["v|K"] = map_cmd(":m '<-2<CR>gv=gv"):with_desc("edit: Move this line up"),
		["v|<"] = map_cmd("<gv"):with_desc("edit: Decrease indent"),
		["v|>"] = map_cmd(">gv"):with_desc("edit: Increase indent"),

		-- Builtin: "Suckless" - named after r/suckless
		["n|Y"] = map_cmd("y$"):with_desc("edit: Yank text to EOL"),
		["n|D"] = map_cmd("d$"):with_desc("edit: Delete text to EOL"),
		["n|n"] = map_cmd("nzzzv"):with_noremap():with_desc("edit: Next search result"),
		["n|N"] = map_cmd("Nzzzv"):with_noremap():with_desc("edit: Prev search result"),
		["n|J"] = map_cmd("mzJ`z"):with_noremap():with_desc("edit: Join next line"),
		["n|<S-Tab>"] = map_cmd("za"):with_desc("edit: Toggle code fold"),
		["n|<Esc>"] = map_callback(function()
				helpers.flash_esc_or_noh()
			end)
			:with_noremap()
			:with_silent()
			:with_desc("edit: Clear search highlight"),
		["n|<leader><leader>o"] = map_cr("setlocal spell! spelllang=en_us"):with_desc("edit: Toggle spell check"),

		-- Builtin: Lsp
		["n|<leader>lv"] = map_callback(function()
				helpers.toggle_virtuallines()
			end)
			:with_noremap()
			:with_silent()
			:with_desc("edit: Toggle virtual lines"),
		["n|<leader>lh"] = map_callback(function()
				helpers.toggle_inlayhint()
			end)
			:with_noremap()
			:with_silent()
			:with_desc("edit: Toggle display of inlay hints"),
	},

	plug_map = {
		-- Plugin persisted.nvim
		["n|<leader>ss"] = map_cu("Persisted save"):with_noremap():with_silent():with_desc("session: Save"),
		["n|<leader>sl"] = map_cu("Persisted load"):with_noremap():with_silent():with_desc("session: Load current"),
		["n|<leader>sd"] = map_cu("Persisted delete"):with_noremap():with_silent():with_desc("session: Delete"),

		-- Plugin: grug-far
		["n|<leader>Ss"] = map_callback(function()
				require("grug-far").open()
			end)
			:with_silent()
			:with_noremap()
			:with_desc("editn: Toggle search & replace panel"),
		["n|<leader>Sp"] = map_callback(function()
				require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
			end)
			:with_silent()
			:with_noremap()
			:with_desc("editn: search & replace current word (project)"),
		["v|<leader>Sp"] = map_callback(function()
				require("grug-far").with_visual_selection()
			end)
			:with_silent()
			:with_noremap()
			:with_desc("edit: search & replace current word (project)"),
		["n|<leader>Sf"] = map_callback(function()
				require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
			end)
			:with_silent()
			:with_noremap()
			:with_desc("editn: search & replace current word (file)"),

		-- Plugin: treesj
		["n|<C-e>"] = map_cu("lua require('treesj').toggle()")
			:with_noremap()
			:with_desc("edit: Toggle node under cursor"),
		["n|<C-S-e>"] = map_cu("lua require('treesj').toggle({ split = { recursive = true } })")
			:with_noremap()
			:with_desc("edit: Toggle node recursively under cursor"),
		["nxo|<A-o>"] = map_callback(function()
				if vim.treesitter.get_parser(nil, nil, { error = false }) then
					require("vim.treesitter._select").select_parent(vim.v.count1)
				else
					vim.lsp.buf.selection_range(vim.v.count1)
				end
			end)
			:with_silent()
			:with_noremap()
			:with_desc("editn: Select parent treesitter node or outer incremental lsp selections"),
		["nxo|<A-i>"] = map_callback(function()
				if vim.treesitter.get_parser(nil, nil, { error = false }) then
					require("vim.treesitter._select").select_child(vim.v.count1)
				else
					vim.lsp.buf.selection_range(-vim.v.count1)
				end
			end)
			:with_silent()
			:with_noremap()
			:with_desc("editn: Select child treesitter node or inner incremental lsp selections"),

		-- Plugin suda.vim
		["n|<C-S-s>"] = map_cu("SudaWrite"):with_silent():with_noremap():with_desc("edit: Save file using sudo"),

		-- Plugin otter
		["n|<leader>lo"] = map_cu("lua require('otter').activate()")
			:with_silent()
			:with_noremap()
			:with_desc("edit: enable lsp in makrdown(otter)"),
		["n|<leader>lO"] = map_cu("lua require('otter').deactivate()")
			:with_silent()
			:with_noremap()
			:with_desc("edit: disable lsp in makrdown(otter)"),

		-- Plugin: nvim-treesitter-textobjects
		-- Text objects: select
		["xo|af"] = map_callback(function()
				ts_to_select.select_textobject("@function.outer", "textobjects")
			end)
			:with_silent()
			:with_noremap()
			:with_desc("editxo: Select function.outer"),
		["xo|if"] = map_callback(function()
				ts_to_select.select_textobject("@function.inner", "textobjects")
			end)
			:with_silent()
			:with_noremap()
			:with_desc("editxo: Select function.inner"),
		["xo|ac"] = map_callback(function()
				ts_to_select.select_textobject("@class.outer", "textobjects")
			end)
			:with_silent()
			:with_noremap()
			:with_desc("editxo: Select class.outer"),
		["xo|ic"] = map_callback(function()
				ts_to_select.select_textobject("@class.inner", "textobjects")
			end)
			:with_silent()
			:with_noremap()
			:with_desc("editoxo: Select class.inner"),
		-- Text objects: swap
		["n|<leader>w"] = map_callback(function()
				ts_to_swap.swap_next("@parameter.inner")
			end)
			:with_silent()
			:with_noremap()
			:with_desc("editn: Swap parameter.inner"),
		["n|<leader>W"] = map_callback(function()
				ts_to_swap.swap_next("@parameter.outer")
			end)
			:with_silent()
			:with_noremap()
			:with_desc("editn: Swap parameter.outer"),
		-- Text objects: move
		["nxo|]["] = map_callback(function()
				ts_to_move.goto_next_start("@function.outer", "textobjects")
			end)
			:with_silent()
			:with_noremap()
			:with_desc("editnxo: Move to next function.outer start"),
		["nxo|]m"] = map_callback(function()
				ts_to_move.goto_next_start("@class.outer", "textobjects")
			end)
			:with_silent()
			:with_noremap()
			:with_desc("editnxo: Move to next class.outer start"),
		["nxo|]]"] = map_callback(function()
				ts_to_move.goto_next_end("@function.outer", "textobjects")
			end)
			:with_silent()
			:with_noremap()
			:with_desc("editnxo: Move to next function.outer end"),
		["nxo|[["] = map_callback(function()
				ts_to_move.goto_previous_start("@function.outer", "textobjects")
			end)
			:with_silent()
			:with_noremap()
			:with_desc("editnxo: Move to previous function.outer start"),
		["nxo|[m"] = map_callback(function()
				ts_to_move.goto_previous_start("@class.outer", "textobjects")
			end)
			:with_silent()
			:with_noremap()
			:with_desc("editnxo: Move to previous class.outer start"),
		["nxo|[]"] = map_callback(function()
				ts_to_move.goto_previous_end("@function.outer", "textobjects")
			end)
			:with_silent()
			:with_noremap()
			:with_desc("editnxo: Move to previous function.outer end"),
		-- movements repeat
		["nxo|;"] = map_callback(function()
				ts_to_repeat_move.repeat_last_move_next()
			end)
			:with_silent()
			:with_noremap()
			:with_desc("editnxo: Repeat last move"),
	},
}

bind.nvim_load_mapping(mappings.builtins)
bind.nvim_load_mapping(mappings.plug_map)
