local _inlay_enabled = require("core.settings").lsp_inlayhints
local M = {}

M.command_panel = function()
	require("snacks").picker.keymaps()
end

M.flash_esc_or_noh = function()
	local flash_active, state = pcall(function()
		return require("flash.plugins.char").state
	end)
	if flash_active and state then
		state:hide()
	else
		pcall(vim.cmd.noh)
	end
end

M.toggle_inlayhint = function()
	_inlay_enabled = not _inlay_enabled
	vim.lsp.inlay_hint.enable(_inlay_enabled)
	vim.notify(
		_inlay_enabled and "Inlay hint enabled " or "Inlay hint disabled",
		vim.log.levels.INFO,
		{ title = "LSP Inlay Hint" }
	)
end

M.toggle_virtuallines = function()
	require("tiny-inline-diagnostic").toggle()
	vim.notify(
		"Virtual lines are now "
			.. (require("tiny-inline-diagnostic.state").user_toggle_state and "displayed" or "hidden"),
		vim.log.levels.INFO,
		{ title = "LSP Diagnostic" }
	)
end

return M
