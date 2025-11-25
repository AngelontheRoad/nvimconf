return function()
	require("overseer").setup({
		-- Default task strategy
		strategy = {
			"toggleterm",
			-- load your default shell before starting the task
			use_shell = false,
			-- overwrite the default toggleterm "direction" parameter
			direction = nil,
			-- overwrite the default toggleterm "highlights" parameter
			highlights = nil,
			-- overwrite the default toggleterm "auto_scroll" parameter
			auto_scroll = nil,
			-- have the toggleterm window close and delete the terminal buffer
			-- automatically after the task exits
			close_on_exit = false,
			-- have the toggleterm window close without deleting the terminal buffer
			-- automatically after the task exits
			-- can be "never, "success", or "always". "success" will close the window
			-- only if the exit code is 0.
			quit_on_exit = "never",
			-- open the toggleterm window when a task starts
			open_on_start = true,
			-- mirrors the toggleterm "hidden" parameter, and keeps the task from
			-- being rendered in the toggleable window
			hidden = false,
			-- command to run when the terminal is created. Combine with `use_shell`
			-- to run a terminal command before starting the task
			on_create = nil,
		},
		-- Template modules to load
		templates = { "builtin", "c", "cpp", "python" },
		-- When true, tries to detect a green color from your colorscheme to use for success highlight
		auto_detect_success_color = true,
		-- Patch nvim-dap to support preLaunchTask and postDebugTask
		dap = true,
		-- Configure the task output buffer and window
		output = {
			-- Use a terminal buffer to display output. If false, a normal buffer is used
			use_terminal = true,
			-- If true, don't clear the buffer when a task restarts
			preserve_output = false,
		},
		-- Configure the task list
		task_list = {
			-- Default direction. Can be "left", "right", or "bottom"
			direction = "bottom",
			-- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			-- min_width and max_width can be a single value or a list of mixed integer/float types.
			-- max_width = {100, 0.2} means "the lesser of 100 columns or 20% of total"
			max_width = { 100, 0.2 },
			-- min_width = {40, 0.1} means "the greater of 40 columns or 10% of total"
			min_width = { 40, 0.1 },
			max_height = { 20, 0.2 },
			min_height = 8,
			-- String that separates tasks
			separator = "────────────────────────────────────────",
			-- Indentation for child tasks
			child_indent = { "┃ ", "┣━", "┗━" },
			-- Function that renders tasks. See lua/overseer/render.lua for built-in options
			-- and for useful functions if you want to build your own.
			render = function(task)
				return require("overseer.render").format_standard(task)
			end,
			-- The sort function for tasks
			sort = function(a, b)
				return require("overseer.task_list").default_sort(a, b)
			end,
			-- Set keymap to false to remove default behavior
			-- You can add custom keymaps here as well (anything vim.keymap.set accepts)
			keymaps = {
				["?"] = "keymap.show_help",
				["g?"] = "keymap.show_help",
				["<CR>"] = "keymap.run_action",
				["dd"] = { "keymap.run_action", opts = { action = "dispose" }, desc = "Dispose task" },
				["<C-e>"] = { "keymap.run_action", opts = { action = "edit" }, desc = "Edit task" },
				["o"] = "keymap.open",
				["<C-v>"] = { "keymap.open", opts = { dir = "vsplit" }, desc = "Open task output in vsplit" },
				["<C-s>"] = { "keymap.open", opts = { dir = "split" }, desc = "Open task output in split" },
				["<C-t>"] = { "keymap.open", opts = { dir = "tab" }, desc = "Open task output in tab" },
				["<C-f>"] = { "keymap.open", opts = { dir = "float" }, desc = "Open task output in float" },
				["<C-q>"] = {
					"keymap.run_action",
					opts = { action = "open output in quickfix" },
					desc = "Open task output in the quickfix",
				},
				["p"] = "keymap.toggle_preview",
				["{"] = "keymap.prev_task",
				["}"] = "keymap.next_task",
				-- ["<C-k>"] = "keymap.scroll_output_up",
				-- ["<C-j>"] = "keymap.scroll_output_down",
				["g."] = "keymap.toggle_show_wrapped",
				["q"] = { "<CMD>close<CR>", desc = "Close task list" },
			},
		},
		-- See :help overseer-actions
		actions = {},
		-- Configure the floating window used for task templates that require input
		-- and the floating window used for editing tasks
		form = {
			zindex = 40,
			-- Dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			-- min_X and max_X can be a single value or a list of mixed integer/float types.
			min_width = 80,
			max_width = 0.9,
			min_height = 10,
			max_height = 0.9,
			-- Set any window options here (e.g. winhighlight)
			win_opts = {},
		},
		-- Configuration for task floating output windows
		task_win = {
			-- How much space to leave around the floating window
			padding = 2,
			-- Set any window options here (e.g. winhighlight)
			win_opts = {},
		},
		-- Aliases for bundles of components. Redefine the builtins, or create your own.
		component_aliases = {
			-- Most tasks are initialized with the default components
			default = {
				"on_exit_set_status",
				"on_complete_notify",
				{ "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
			},
			-- Tasks from tasks.json use these components
			default_vscode = {
				"default",
				"on_result_diagnostics",
			},
			-- Tasks created from experimental_wrap_builtins
			default_builtin = {
				"on_exit_set_status",
				"on_complete_dispose",
				{ "unique", soft = true },
			},
		},
		-- List of other directories to search for task templates.
		-- This will search under the runtimepath, so for example
		-- "foo/bar" will search "<runtimepath>/lua/foo/bar/*"
		template_dirs = { "overseer" },
		-- For template providers, how long to wait before timing out.
		-- Set to 0 to wait forever.
		template_timeout_ms = 3000,
		-- Cache template provider results if the provider takes longer than this to run.
		-- Set to 0 to disable caching.
		template_cache_threshold_ms = 200,
		log_level = vim.log.levels.WARN,
		-- Overseer can wrap any call to vim.system and vim.fn.jobstart as a task.
		experimental_wrap_builtins = {
			enabled = false,
			condition = function(cmd, caller, opts)
				return true
			end,
		},
	})
end
