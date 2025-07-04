return function()
	local trouble_filter = function(position)
		return function(_, win)
			return vim.w[win].trouble
				and vim.w[win].trouble.position == position
				and vim.w[win].trouble.type == "split"
				and vim.w[win].trouble.relative == "editor"
				and not vim.w[win].trouble_preview
		end
	end

	require("modules.utils").load_plugin("edgy", {
		animate = { enabled = false },
		close_when_all_hidden = true,
		exit_when_last = true,
		wo = { winbar = false },
		keys = {
			["q"] = false,
			["Q"] = false,
			["<C-q>"] = false,
			["<A-j>"] = function(win)
				win:resize("height", -2)
			end,
			["<A-k>"] = function(win)
				win:resize("height", 2)
			end,
			["<A-h>"] = function(win)
				win:resize("width", -2)
			end,
			["<A-l>"] = function(win)
				win:resize("width", 2)
			end,
		},
		left = {
			{
				ft = "NvimTree",
				pinned = true,
				collapsed = false,
				size = { height = 0.6, width = 40 },
				open = "NvimTreeOpen",
			},
			{
				ft = "trouble",
				pinned = true,
				collapsed = false,
				size = { height = 0.4, width = 40 },
				open = function()
					if vim.b.buftype == "" then
						return "Trouble symbols toggle win.position=right"
					end
				end,
				filter = trouble_filter("right"),
			},
		},
		bottom = {
			{ ft = "qf", size = { height = 0.3 } },
			{
				ft = "toggleterm",
				size = { height = 0.3 },
				filter = function(_, win)
					local not_floating = vim.api.nvim_win_get_config(win).relative == ""
					local term = require("toggleterm.terminal").get(1)
					return not_floating and term.direction == "horizontal"
				end,
			},
			{
				ft = "help",
				size = { height = 0.3 },
				filter = function(buf)
					return vim.bo[buf].buftype == "help"
				end,
			},
		},
	})
end
