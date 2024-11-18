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

_G._toggle_inlayhint = function(filter)
	if vim.lsp.inlay_hint.is_enabled(filter) then
		vim.lsp.inlay_hint.enable(false, filter)
		if filter then
			vim.notify("Hide global inlay hint successfully!", vim.log.levels.INFO, { title = "LSP Inlay Hint" })
		else
			vim.notify("Hide buffer inlay hint successfully!", vim.log.levels.INFO, { title = "LSP Inlay Hint" })
		end
	else
		vim.lsp.inlay_hint.enable(true, filter)
		if filter then
			vim.notify("Show global inlay hint successfully!", vim.log.levels.INFO, { title = "LSP Inlay Hint" })
		else
			vim.notify("Show buffer inlay hint successfully!", vim.log.levels.INFO, { title = "LSP Inlay Hint" })
		end
	end
end

local _global_virt_state = require("core.settings").diagnostics_virtual_text
local _buf_virt_state = {}
_G._toggle_diagnostic = function(bufnr)
	if vim.diagnostic.is_enabled({ bufnr = bufnr }) then
		-- specific buffer number
		if bufnr then
			local num = vim.fn.bufnr(bufnr)
			if _buf_virt_state[num] then
				_buf_virt_state[num] = false
				vim.diagnostic.hide(nil, bufnr)
				vim.notify("Hide buffer virtual text successfully!", vim.log.levels.INFO, { title = "LSP Diagnostic" })
			else
				_buf_virt_state[num] = true
				vim.diagnostic.show(nil, bufnr)
				vim.notify("Show buffer virtual text successfully!", vim.log.levels.INFO, { title = "LSP Diagnostic" })
			end
		-- globally
		else
			if _global_virt_state then
				_global_virt_state = false
				for i, _ in pairs(_buf_virt_state) do
					_buf_virt_state[i] = false
				end
				vim.diagnostic.hide(nil)
				vim.notify("Hide global virtual text successfully!", vim.log.levels.INFO, { title = "LSP Diagnostic" })
			else
				_global_virt_state = true
				for i, _ in pairs(_buf_virt_state) do
					_buf_virt_state[i] = true
				end
				vim.diagnostic.show(nil)
				vim.notify("Show global virtual text successfully!", vim.log.levels.INFO, { title = "LSP Diagnostic" })
			end
		end
	end
end
