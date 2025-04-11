local _inlay_enabled = require("core.settings").lsp_inlayhints
local _global_vt_enabled = require("core.settings").diagnostics_virtual_text
local _global_vl_enabled = require("core.settings").diagnostics_virtual_lines

_G._command_panel = function()
	require("telescope.builtin").keymaps({
		lhs_filter = function(lhs)
			return not string.find(lhs, "Þ")
		end,
	})
end

_G._flash_esc_or_noh = function()
	local flash_active, state = pcall(function()
		return require("flash.plugins.char").state
	end)
	if flash_active and state then
		state:hide()
	else
		pcall(vim.cmd.noh)
	end
end

_G._telescope_collections = function(picker_type)
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local conf = require("telescope.config").values
	local finder = require("telescope.finders")
	local pickers = require("telescope.pickers")
	picker_type = picker_type or {}

	local collections = vim.tbl_keys(require("search.tabs").collections)
	pickers
		.new(picker_type, {
			prompt_title = "Telescope Collections",
			finder = finder.new_table({ results = collections }),
			sorter = conf.generic_sorter(picker_type),
			attach_mappings = function(bufnr)
				actions.select_default:replace(function()
					actions.close(bufnr)
					local selection = action_state.get_selected_entry()
					require("search").open({ collection = selection[1] })
				end)

				return true
			end,
		})
		:find()
end

local _lazygit = nil
_G._toggle_lazygit = function()
	if vim.fn.executable("lazygit") == 1 then
		if not _lazygit then
			_lazygit = require("toggleterm.terminal").Terminal:new({
				cmd = "lazygit",
				direction = "float",
				close_on_exit = true,
				hidden = true,
			})
		end
		_lazygit:toggle()
	else
		vim.notify("Command [lazygit] not found!", vim.log.levels.ERROR, { title = "toggleterm.nvim" })
	end
end

local _global_inlay_enabled = _inlay_enabled
_G._toggle_inlayhint = function(filter)
	if filter then
		local state = not vim.lsp.inlay_hint.is_enabled(filter)
		vim.lsp.inlay_hint.enable(state, filter)
		vim.notify(
			state and "Inlay hint enabled in current buffer" or "Inlay hint disabled in current buffer",
			vim.log.levels.INFO,
			{ title = "LSP Inlay Hint" }
		)
	else
		_global_inlay_enabled = not _global_inlay_enabled
		vim.lsp.inlay_hint.enable(_global_inlay_enabled)
		vim.notify(
			_global_inlay_enabled and "Inlay hint enabled globally" or "Inlay hint disabled globally",
			vim.log.levels.INFO,
			{ title = "LSP Inlay Hint" }
		)
	end
end

_G._toggle_virtualtextandlines = function()
	_global_vt_enabled = not _global_vt_enabled
	_global_vl_enabled = not _global_vl_enabled
	vim.diagnostic.config({ virtual_text = _global_vt_enabled, virtual_lines = _global_vl_enabled })
	-- vim.diagnostic[_global_vt_enabled and "show" or "hide"](nil, bufnr)
	vim.notify(
		_global_vt_enabled and "Virtual text is now displayed globally" or "Virtual text is now hidden globally",
		vim.log.levels.INFO,
		{ title = "LSP Diagnostic" }
	)
	vim.notify(
		_global_vl_enabled and "Virtual lines are now dareplayed globally" or "Virtual lines are now hidden globally",
		vim.log.levels.INFO,
		{ title = "LSP Diagnostic" }
	)
end
