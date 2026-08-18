local bind = require("keymap.bind")
local map_callback = bind.map_callback
local map_cr = bind.map_cr
local snack = require("snacks").picker
local git_search = require("advanced_git_search.snacks.pickers")

local mappings = {
	-- Plugin: advanced-git-search.nvim
	["n|<leader>gl"] = map_callback(function()
			git_search.search_log_content()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("git: Search log content"),
	["n|<leader>gf"] = map_callback(function()
			git_search.diff_commit_file()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("git: Diff current file"),

	-- Plugin: diffview.nvim
	["n|<leader>gd"] = map_cr("DiffviewOpen"):with_silent():with_noremap():with_desc("git: Show diff"),
	["n|<leader>gD"] = map_cr("DiffviewClose"):with_silent():with_noremap():with_desc("git: Close diff"),

	-- Plugin: snacks.git
	["n|<leader>gB"] = map_callback(function()
			snack.git_branches()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("git: Branches"),
	["n|<leader>gc"] = map_callback(function()
			snack.git_log()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("git: Commits"),
	["n|<leader>gS"] = map_callback(function()
			snack.git_status()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("git: Status"),
}

bind.nvim_load_mapping(mappings)

local M = {}

function M.gitsigns(bufnr)
	local gitsigns = require("gitsigns")

	local map = {
		["n|]g"] = map_callback(function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gitsigns.nav_hunk("next")
				end)
				return "<Ignore>"
			end)
			:with_buffer(bufnr)
			:with_noremap()
			:with_expr()
			:with_desc("git: Goto next hunk"),
		["n|[g"] = map_callback(function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gitsigns.nav_hunk("prev")
				end)
				return "<Ignore>"
			end)
			:with_buffer(bufnr)
			:with_noremap()
			:with_expr()
			:with_desc("git: Goto prev hunk"),
		["n|<leader>gs"] = map_callback(function()
				gitsigns.stage_hunk()
			end)
			:with_buffer(bufnr)
			:with_noremap()
			:with_desc("git: Toggle staging/unstaging of hunk"),
		["v|<leader>gs"] = map_callback(function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end)
			:with_buffer(bufnr)
			:with_noremap()
			:with_desc("git: Toggle staging/unstaging of selected hunk"),
		["n|<leader>gr"] = map_callback(function()
				gitsigns.reset_hunk()
			end)
			:with_buffer(bufnr)
			:with_noremap()
			:with_desc("git: Reset hunk"),
		["v|<leader>gr"] = map_callback(function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end)
			:with_buffer(bufnr)
			:with_noremap()
			:with_desc("git: Reset hunk"),
		["n|<leader>gR"] = map_callback(function()
				gitsigns.reset_buffer()
			end)
			:with_buffer(bufnr)
			:with_noremap()
			:with_desc("git: Reset buffer"),
		["n|<leader>gp"] = map_callback(function()
				gitsigns.preview_hunk()
			end)
			:with_buffer(bufnr)
			:with_noremap()
			:with_desc("git: Preview hunk"),
		["n|<leader>gb"] = map_callback(function()
				gitsigns.blame_line({ full = true })
			end)
			:with_buffer(bufnr)
			:with_noremap()
			:with_desc("git: Blame line"),
		-- Text objects
		["ox|ih"] = map_callback(function()
				gitsigns.select_hunk()
			end)
			:with_noremap()
			:with_buffer(bufnr),
	}
	bind.nvim_load_mapping(map)
end

return M
