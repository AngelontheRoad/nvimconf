return function()
	local icons = {
		diagnostics = require("modules.utils.icons").get("diagnostics"),
		documents = require("modules.utils.icons").get("documents", true),
		git = require("modules.utils.icons").get("git", true),
		ui = require("modules.utils.icons").get("ui", true),
		misc = require("modules.utils.icons").get("misc", true),
	}

	require("modules.utils").load_plugin("snacks", {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		bufdelete = { enabled = true },
		dashboard = {
			enabled = true,
			preset = {
				header = table.concat(require("core.settings").dashboard_image, "\n"),
				keys = {
					{
						icon = icons.documents.Files,
						key = "f",
						desc = "Find file",
						action = ":lua require('snacks').picker.files()",
					},
					{ icon = icons.ui.NewFile, key = "e", desc = "New file", action = ":ene" },
					{
						icon = icons.git.Repo,
						key = "p",
						desc = "Find project",
						action = ":lua require('snacks').picker.projects()",
					},
					{
						icon = icons.ui.Sort,
						key = "y",
						desc = "File frecency",
						action = ":lua require('snacks').picker.smart()",
					},
					{
						icon = icons.ui.History,
						key = "r",
						desc = "Recent files",
						action = ":lua require('snacks').picker.recent()",
					},
					{
						icon = icons.ui.List,
						key = "s",
						desc = "Find text",
						action = ":lua require('snacks').picker.grep()",
					},
					-- {
					-- 	icon = icons.ui.CloudDownload,
					-- 	key = "u",
					-- 	desc = "Update",
					-- 	action = ":Lazy sync",
					-- },
					{
						icon = icons.ui.SignOut,
						key = "q",
						desc = "Quit",
						action = ":qa",
					},
				},
			},
			sections = {
				{ section = "header", hl = "SnacksDashboardHeader" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
			},
		},
		explorer = { enabled = false },
		image = { enabled = true },
		indent = {
			enabled = true,
			indent = {
				char = "│",
				only_scope = false,
			},
			animate = {
				enabled = true,
				style = "out",
				easing = "linear",
				duration = { step = 20, total = 300 },
			},
			scope = {
				enabled = true,
				char = "┃",
				underline = false,
			},
			chunk = { enabled = false },
			---@param buf number
			filter = function(buf, _)
				local excluded_ft = {
					[""] = true,
					checkhealth = true,
					["dap-repl"] = true,
					diff = true,
					fugitive = true,
					fugitiveblame = true,
					git = true,
					gitcommit = true,
					help = true,
					log = true,
					markdown = true,
					Outline = true,
					qf = true,
					snacks_dashboard = true,
					text = true,
					undotree = true,
					vimwiki = true,
				}
				return vim.g.snacks_indent ~= false
					and vim.b[buf].snacks_indent ~= false
					and vim.bo[buf].buftype == ""
					and not excluded_ft[vim.bo[buf].filetype]
			end,
		},
		input = { enabled = true },
		lazygit = { enabled = true },
		picker = {
			enabled = true,
			sources = {
				smart = { matcher = { frecency = true } },
			},
			win = {
				input = {
					keys = {
						["<a-s>"] = { "flash", mode = { "n", "i" } },
						["<c-e>"] = { "qflist", mode = { "i", "n" } },
						["s"] = { "flash" },
					},
				},
				list = {
					keys = {
						["<c-e>"] = { "qflist" },
					},
				},
			},
			actions = {
				flash = function(picker)
					require("flash").jump({
						pattern = "^",
						label = { after = { 0, 0 } },
						search = {
							mode = "search",
							exclude = {
								function(win)
									return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
								end,
							},
						},
						action = function(match)
							local idx = picker.list:row2idx(match.pos[1])
							picker.list:_move(idx, true, true)
						end,
					})
				end,
			},
		},
		notifier = {
			enabled = true,
			timeout = 2000,
			icons = {
				error = icons.diagnostics.Error,
				warn = icons.diagnostics.Warning,
				info = icons.diagnostics.Information,
				debug = icons.ui.Bug,
				trace = icons.ui.Pencil,
			},
			-- style = "compact",
		},
		quickfile = { enabled = true },
		scope = { enabled = false },
		scratch = { enabled = true },
		scroll = {
			enabled = true,
			animate = {
				duration = { step = 15, total = 150 },
				easing = "linear",
			},
			-- faster animation when repeating scroll after delay
			animate_repeat = {
				delay = 100, -- delay in ms before using the repeat animation
				duration = { step = 5, total = 50 },
				easing = "linear",
			},
		},
		statuscolumn = { enabled = false },
		terminal = {
			enabled = true,
			win = { border = "rounded" },
		},
		words = { enabled = false },
	})
end
