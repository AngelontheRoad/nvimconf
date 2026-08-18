local icons = {
	kind = require("modules.utils.icons").get("kind"),
	type = require("modules.utils.icons").get("type"),
	cmp = require("modules.utils.icons").get("cmp"),
}

---@module "blink.cmp"
---@type blink.cmp.Config
local opts = {
	keymap = {
		preset = "default",
		["<C-n>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback" },
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
		["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
		["<C-c>"] = { "cancel", "hide", "fallback" },
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-f>"] = { "scroll_documentation_up", "fallback" },
		["<C-d>"] = { "scroll_documentation_down", "fallback" },
		["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
	},
	appearance = {
		nerd_font_variant = "normal",
	},

	cmdline = {
		enabled = true,
		keymap = {
			preset = "cmdline",
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<CR>"] = { "accept_and_enter", "fallback" },
			["<C-c>"] = { "cancel", "hide", "fallback" },
			["<C-e>"] = { "cancel", "fallback" },
			["<C-f>"] = { "accept", "fallback" },
		},
		sources = {
			default = function()
				local cmdtype = vim.fn.getcmdtype()
				if cmdtype == "/" or cmdtype == "?" then
					return { "buffer" }
				end
				if cmdtype == ":" or cmdtype == "@" then
					return { "cmdline", "path" }
				end
				return {}
			end,
		},
		completion = {
			list = { selection = { preselect = false, auto_insert = true } },
			menu = {
				auto_show = true,
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind", gap = 1 },
						{ "source_name" },
					},
				},
			},
			ghost_text = { enabled = false },
		},
	},

	completion = {
		accept = {
			auto_brackets = {
				enabled = true,
				kind_resolution = { enabled = true },
				semantic_token_resolution = {
					enabled = true,
					blocked_filetypes = { "java" },
				},
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
			treesitter_highlighting = true,
			window = { border = "single" },
		},
		ghost_text = {
			enabled = true,
			show_with_selection = true,
			show_without_selection = false,
			show_with_menu = true,
			show_without_menu = true,
		},
		keyword = { range = "full" },
		list = {
			max_items = 120,
			selection = {
				preselect = false,
				auto_insert = false,
			},
		},
		menu = {
			auto_show = true,
			border = "rounded",
			draw = {
				treesitter = { "lsp" },
				columns = {
					{ "label", gap = 1 },
					{ "kind_icon", "kind", gap = 1 },
					{ "source_name" },
				},
				components = {
					kind_icon = {
						text = function(ctx)
							local lspkind_icons = vim.tbl_deep_extend("force", icons.kind, icons.type, icons.cmp)
							return icons.cmp[ctx.source_id] or lspkind_icons[ctx.kind] or icons.cmp.undefined
						end,
					},
					label = {
						text = function(ctx)
							return require("colorful-menu").blink_components_text(ctx)
						end,
						highlight = function(ctx)
							return require("colorful-menu").blink_components_highlight(ctx)
						end,
					},
				},
			},
		},
	},
	signature = {
		enabled = true,
		trigger = { show_on_insert = true },
		window = {
			border = "single",
			treesitter_highlighting = true,
			show_documentation = true,
		},
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
	snippets = { preset = "luasnip" },
	sources = {
		default = { "lazydev", "lsp", "path", "snippets", "buffer", "ripgrep", "env", "conventional_commits" },
		providers = {
			lsp = { max_items = 350 },
			lazydev = {
				module = "lazydev.integrations.blink",
				name = "LazyDev",
				score_offset = 100,
				enabled = function()
					return vim.bo.filetype == "lua"
				end,
			},
			buffer = {
				score_offset = -10,
				max_items = 3,
				opts = {
					get_bufnrs = function()
						return vim.api.nvim_buf_line_count(0) < 15000 and vim.api.nvim_list_bufs() or {}
					end,
				},
			},
			path = {
				fallbacks = { "snippets", "buffer" },
				opts = {
					trailing_slash = false,
					label_trailing_slash = true,
					get_cwd = function(context)
						return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
					end,
					show_hidden_files_by_default = true,
				},
			},
			conventional_commits = {
				module = "blink-cmp-conventional-commits",
				name = "Commits",
				enabled = function()
					return vim.bo.filetype == "gitcommit"
				end,
			},
			env = {
				module = "blink-cmp-env",
				name = "Env",
				score_offset = -5,
				max_items = 5,
			},
			ripgrep = {
				module = "blink-ripgrep",
				name = "Ripgrep",
				---@module "blink-ripgrep"
				---@type blink-ripgrep.Options
				opts = {
					prefix_min_len = 3,
					backend = {
						use = "ripgrep",
						ripgrep = {
							context_size = 3,
							max_filesize = "200K",
							additional_rg_options = { "--max-count=5" },
							ignore_paths = {
								"/home/chris",
								"/home/chris/.config",
								"/home/chris/.local",
								"/home/chris/.xwechat",
								"/etc",
							},
						},
					},
					debug = false,
				},
				score_offset = -15,
				max_items = 3,
			},
		},
	},

	term = { enabled = false },
}

return function()
	require("modules.utils").load_plugin("blink.cmp", opts)
end
