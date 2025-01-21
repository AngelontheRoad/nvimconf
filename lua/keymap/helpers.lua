local _inlay_enabled = require("core.settings").lsp_inlayhints
local _global_vt_enabled = require("core.settings").diagnostics_virtual_text

_G._command_panel = function()
	require("telescope.builtin").keymaps({
		lhs_filter = function(lhs)
			return not string.find(lhs, "Þ")
		end,
		layout_config = {
			width = 0.6,
			height = 0.6,
			prompt_position = "top",
		},
	})
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

local _buf_vt_enabled = {}
_G._toggle_diagnostic = function(bufnr)
	if bufnr then
		local num = vim.fn.bufnr()
		if _buf_vt_enabled[num] == nil then
			_buf_vt_enabled[num] = not _global_vt_enabled
		else
			_buf_vt_enabled[num] = not _buf_vt_enabled[num]
		end
		local state = _buf_vt_enabled[num]
		vim.diagnostic[state and "show" or "hide"](nil, bufnr)
		vim.notify(
			state and "Virtual text is now displayed in current buffer"
				or "Virtual text is now hidden in current buffer",
			vim.log.levels.INFO,
			{ title = "LSP Diagnostic" }
		)
		-- globally
	else
		_global_vt_enabled = not _global_vt_enabled
		local bufnrs = vim.api.nvim_list_bufs()
		for _, num in pairs(bufnrs) do
			if vim.api.nvim_buf_is_loaded(num) then
				_buf_vt_enabled[num] = _global_vt_enabled
			end
		end
		vim.diagnostic[_global_vt_enabled and "show" or "hide"]()
		vim.notify(
			_global_vt_enabled and "Virtual text is now displayed globally" or "Virtual text is now hidden globally",
			vim.log.levels.INFO,
			{ title = "LSP Diagnostic" }
		)
	end
end

_G._async_compile_and_debug = function()
	local file_ext = vim.fn.expand("%:e")
	local file_path = vim.fn.expand("%:p")
	local out_name = vim.fn.expand("%:p:h") .. "/" .. vim.fn.expand("%:t:r") .. ".out"
	local compile_cmd
	if file_ext == "cpp" or file_ext == "cc" then
		compile_cmd = string.format("g++ -g %s -o %s", file_path, out_name)
	elseif file_ext == "c" then
		compile_cmd = string.format("gcc -g %s -o %s", file_path, out_name)
	elseif file_ext == "go" then
		compile_cmd = string.format("go build -o %s %s", out_name, file_path)
	else
		require("dap").continue()
		return
	end
	local notify_title = "Debug Pre-compile"
	vim.fn.jobstart(compile_cmd, {
		on_exit = function(_, exit_code, _)
			if exit_code == 0 then
				vim.notify(
					"Compilation succeeded! Executable: " .. out_name,
					vim.log.levels.INFO,
					{ title = notify_title }
				)
				require("dap").continue()
				return
			else
				vim.notify(
					"Compilation failed with exit code: " .. exit_code,
					vim.log.levels.ERROR,
					{ title = notify_title }
				)
			end
		end,
	})
end
