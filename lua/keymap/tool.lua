local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
local vim_path = require("core.global").vim_path
local helpers = require("keymap.helpers")

local mappings = {
	plugins = {
		-- Plugin: vim-fugitive
		["n|gps"] = map_cr("G push"):with_noremap():with_silent():with_desc("git: Push"),
		["n|gpl"] = map_cr("G pull"):with_noremap():with_silent():with_desc("git: Pull"),
		["n|<leader>gG"] = map_cu("Git"):with_noremap():with_silent():with_desc("git: Open git-fugitive"),

		-- Plugin: edgy
		["n|<C-n>"] = map_callback(function()
				require("edgy").toggle("left")
			end)
			:with_noremap()
			:with_silent()
			:with_desc("filetree: Nvimtree Toggle"),

		["n|<C-y>"] = map_cr("Yazi toggle"):with_noremap():with_silent():with_desc("filetree: Yazi toggle"),

		-- Plugin: sniprun
		["v|<F5>"] = map_cr("SnipRun"):with_noremap():with_silent():with_desc("tool: Run code by range"),
		["n|<F5>"] = map_cu([[%SnipRun]]):with_noremap():with_silent():with_desc("tool: Run code by file"),

		-- Plugin: toggleterm
		["t|<Esc><Esc>"] = map_cmd([[<C-\><C-n>]]):with_noremap():with_silent(), -- switch to normal mode in terminal.
		["n|<C-\\>"] = map_cr("ToggleTerm direction=horizontal")
			:with_noremap()
			:with_silent()
			:with_desc("terminal: Toggle horizontal"),
		["i|<C-\\>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=horizontal<CR>")
			:with_noremap()
			:with_silent()
			:with_desc("terminal: Toggle horizontal"),
		["t|<C-\\>"] = map_cmd("<Cmd>ToggleTerm<CR>")
			:with_noremap()
			:with_silent()
			:with_desc("terminal: Toggle horizontal"),
		["n|<A-\\>"] = map_cr("ToggleTerm direction=vertical")
			:with_noremap()
			:with_silent()
			:with_desc("terminal: Toggle vertical"),
		["i|<A-\\>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=vertical<CR>")
			:with_noremap()
			:with_silent()
			:with_desc("terminal: Toggle vertical"),
		["t|<A-\\>"] = map_cmd("<Cmd>ToggleTerm<CR>")
			:with_noremap()
			:with_silent()
			:with_desc("terminal: Toggle vertical"),
		["n|<A-d>"] = map_cr("ToggleTerm direction=float")
			:with_noremap()
			:with_silent()
			:with_desc("terminal: Toggle float"),
		["i|<A-d>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=float<CR>")
			:with_noremap()
			:with_silent()
			:with_desc("terminal: Toggle float"),
		["t|<A-d>"] = map_cmd("<Cmd>ToggleTerm<CR>"):with_noremap():with_silent():with_desc("terminal: Toggle float"),
		["n|<leader>gg"] = map_callback(function()
				helpers.toggle_lazygit()
			end)
			:with_noremap()
			:with_silent()
			:with_desc("git: Toggle lazygit"),

		-- Plugin: trouble
		["n|gt"] = map_cr("Trouble diagnostics toggle")
			:with_noremap()
			:with_silent()
			:with_desc("lsp: Toggle trouble list"),
		["n|<leader>lw"] = map_cr("Trouble diagnostics toggle")
			:with_noremap()
			:with_silent()
			:with_desc("lsp: Show workspace diagnostics"),
		["n|<leader>lp"] = map_cr("Trouble project_diagnostics toggle")
			:with_noremap()
			:with_silent()
			:with_desc("lsp: Show project diagnostics"),
		["n|<leader>ld"] = map_cr("Trouble diagnostics toggle filter.buf=0")
			:with_noremap()
			:with_silent()
			:with_desc("lsp: Show document diagnostics"),
		["n|<leader>lk"] = map_cr("Trouble lsp toggle win.position=right")
			:with_noremap()
			:with_silent()
			:with_desc("lsp: Show document under cursor"),
		["n|<leader>ls"] = map_cr("Trouble symbols toggle win.position=right")
			:with_noremap()
			:with_silent()
			:with_desc("lsp: Show symbols hierarchy"),

		-- Plugin: telescope
		["n|<C-p>"] = map_callback(function()
				helpers.picker("keymaps", {
					lhs_filter = function(lhs)
						return not string.find(lhs, "Þ")
					end,
				})
			end)
			:with_noremap()
			:with_silent()
			:with_desc("tool: Toggle command panel"),
		["n|<leader>fc"] = map_callback(function()
				helpers.telescope_collections(require("telescope.themes").get_dropdown())
			end)
			:with_noremap()
			:with_silent()
			:with_desc("tool: Open Telescope collections"),
		["n|<leader>ff"] = map_callback(function()
				require("search").open({ collection = "file" })
			end)
			:with_noremap()
			:with_silent()
			:with_desc("tool: Find files"),
		["n|<leader>fp"] = map_callback(function()
				require("search").open({ collection = "pattern" })
			end)
			:with_noremap()
			:with_silent()
			:with_desc("tool: Find patterns"),
		["v|<leader>fs"] = map_callback(function()
				local is_config = vim.uv.cwd() == vim_path
				if require("core.settings").search_backend == "fzf" then
					require("fzf-lua").grep_project({
						search = require("fzf-lua.utils").get_visual_selection(),
						rg_opts = "--column --line-number --no-heading --color=always --smart-case"
							.. (is_config and " --no-ignore --hidden --glob '!.git/*'" or ""),
					})
				else
					require("telescope-live-grep-args.shortcuts").grep_visual_selection(
						is_config and { additional_args = { "--no-ignore" } } or {}
					)
				end
			end)
			:with_noremap()
			:with_silent()
			:with_desc("tool: Find word under cursor"),
		["n|<leader>fg"] = map_callback(function()
				require("search").open({ collection = "git" })
			end)
			:with_noremap()
			:with_silent()
			:with_desc("tool: Locate Git objects"),
		["n|<leader>fd"] = map_callback(function()
				require("search").open({ collection = "dossier" })
			end)
			:with_noremap()
			:with_silent()
			:with_desc("tool: Retrieve dossiers"),
		["n|<leader>fm"] = map_callback(function()
				require("search").open({ collection = "misc" })
			end)
			:with_noremap()
			:with_silent()
			:with_desc("tool: Miscellaneous"),
		["n|<leader>fr"] = map_cr("Telescope resume")
			:with_noremap()
			:with_silent()
			:with_desc("tool: Resume last telescope search"),
		["n|<leader>fR"] = map_callback(function()
				if require("core.settings").search_backend == "fzf" then
					require("fzf-lua").resume()
				end
			end)
			:with_noremap()
			:with_silent()
			:with_desc("tool: Resume last fzf search"),

		-- Plugin: dap
		-- use C-w_q to close float window
		["n|<F6>"] = map_callback(function()
				require("dap").continue()
			end)
			:with_noremap()
			:with_silent()
			:with_desc("debug: Run/Continue"),
		["n|<F7>"] = map_callback(function()
				require("dap").terminate()
			end)
			:with_noremap()
			:with_silent()
			:with_desc("debug: Stop"),
		["n|<F8>"] = map_callback(function()
				require("dap").toggle_breakpoint()
			end)
			:with_noremap()
			:with_silent()
			:with_desc("debug: Toggle breakpoint"),
		["n|<F9>"] = map_callback(function()
				require("dap").step_into()
			end)
			:with_noremap()
			:with_silent()
			:with_desc("debug: Step into"),
		["n|<F10>"] = map_callback(function()
				require("dap").step_out()
			end)
			:with_noremap()
			:with_silent()
			:with_desc("debug: Step out"),
		["n|<F11>"] = map_callback(function()
				require("dap").step_over()
			end)
			:with_noremap()
			:with_silent()
			:with_desc("debug: Step over"),
		["n|<leader>db"] = map_callback(function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end)
			:with_noremap()
			:with_silent()
			:with_desc("debug: Set breakpoint with condition"),
		["n|<leader>dc"] = map_callback(function()
				require("dap").run_to_cursor()
			end)
			:with_noremap()
			:with_silent()
			:with_desc("debug: Run to cursor"),
		["n|<leader>df"] = map_callback(function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end)
			:with_noremap()
			:with_silent()
			:with_desc("debug: Center frames"),
		["nv|<leader>dh"] = map_callback(function()
				require("dap.ui.widgets").hover()
			end)
			:with_noremap()
			:with_silent()
			:with_desc("debug: Hover"),
		["n|<leader>dl"] = map_callback(function()
				require("dap").run_last()
			end)
			:with_noremap()
			:with_silent()
			:with_desc("debug: Run last"),
		["n|<leader>do"] = map_callback(function()
				require("dap").repl.open()
			end)
			:with_noremap()
			:with_silent()
			:with_desc("debug: Open REPL"),
		["nv|<leader>dp"] = map_callback(function()
				require("dap.ui.widgets").preview()
			end)
			:with_noremap()
			:with_silent()
			:with_desc("debug: Preview"),
		["n|<leader>dr"] = map_callback(function()
				require("dap").repl.open()
			end)
			:with_noremap()
			:with_silent()
			:with_desc("debug: Open REPL"),
		["n|<leader>ds"] = map_callback(function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end)
			:with_noremap()
			:with_silent()
			:with_desc("debug: Center scopes"),

		-- Plugin: Molten, for jupyter
		["n|<leader>mi"] = map_cr("MoltenInit")
			:with_noremap()
			:with_silent()
			:with_desc("jupyter: Initialize the plugin"),
		["n|<leader>me"] = map_cr("MoltenEvaluateOperator")
			:with_noremap()
			:with_silent()
			:with_desc("jupyter: Run operator selection"),
		["n|<leader>ml"] = map_cr("MoltenEvaluateLine")
			:with_noremap()
			:with_silent()
			:with_desc("jupyter: Evaluate line"),
		["n|<leader>mr"] = map_cr("MoltenReevaluateCell")
			:with_noremap()
			:with_silent()
			:with_desc("jupyter: Re-evaluate cell"),
		["n|<leader>ms"] = map_cr("MoltenInterrupt"):with_noremap():with_silent():with_desc("jupyter: Interrupt"),
		["n|<leader>md"] = map_cr("MoltenDelete"):with_noremap():with_silent():with_desc("jupyter: Delete cell"),
		["n|<leader>mo"] = map_cr("noautocmd MoltenEnterOutput")
			:with_noremap()
			:with_silent()
			:with_desc("jupyter: Show/enter output"),
		["n|<leader>mh"] = map_cr("MoltenHideOutput"):with_noremap():with_silent():with_desc("jupyter: Hide output"),
		["n|<leader>mj"] = map_cr("MoltenPrev")
			:with_noremap()
			:with_silent()
			:with_desc("jupyter: Go to the previous cell"),
		["n|<leader>mk"] = map_cr("MoltenNext"):with_noremap():with_silent():with_desc("jupyter: Go to the next cell"),
		["v|<leader>me"] = map_cmd(":<C-u>MoltenEvaluateVisual<CR>gv")
			:with_noremap()
			:with_silent()
			:with_desc("jupyter: Evaluate visual selection"),

		-- Plugin: overseer
		["n|<leader>ot"] = map_cr("OverseerToggle right")
			:with_noremap()
			:with_silent()
			:with_desc("overseer: Toggle the overseer window"),
		["n|<leader>oi"] = map_cr("OverseerInfo")
			:with_noremap()
			:with_silent()
			:with_desc("overseer: Show overseer info"),
		["n|<leader>or"] = map_cr("OverseerRun"):with_noremap():with_silent():with_desc("overseer: Run command"),
	},
}

bind.nvim_load_mapping(mappings.plugins)
