local bind = require("keymap.bind")
local map_callback = bind.map_callback

-- prefil edit window with common scenarios to avoid repeating query and submit immediately
local prefill_edit_window = function(request)
	require("avante.api").edit()
	local code_bufnr = vim.api.nvim_get_current_buf()
	local code_winid = vim.api.nvim_get_current_win()
	if code_bufnr == nil or code_winid == nil then
		return
	end
	vim.api.nvim_buf_set_lines(code_bufnr, 0, -1, false, { request })
	-- Optionally set the cursor position to the end of the input
	vim.api.nvim_win_set_cursor(code_winid, { 1, #request + 1 })
	-- Simulate Ctrl+S keypress to submit
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-s>", true, true, true), "v", true)
end

-- NOTE: most templates are inspired from ChatGPT.nvim -> chatgpt-actions.json
local avante_grammar_correction = "Correct the text to standard English, but keep any code blocks inside intact."
local avante_keywords = "Extract the main keywords from the following text"
local avante_code_readability_analysis = [[
  You must identify any readability issues in the code snippet.
  Some readability issues to consider:
  - Unclear naming
  - Unclear purpose
  - Redundant or obvious comments
  - Lack of comments
  - Long or complex one liners
  - Too much nesting
  - Long variable names
  - Inconsistent naming and code style.
  - Code repetition
  You may identify additional problems. The user submits a small section of code from a larger file.
  Only list lines with readability issues, in the format <line_num>|<issue and proposed solution>
  If there's no issues with code respond with only: <OK>
]]
local avante_optimize_code = "Optimize the following code"
local avante_summarize = "Summarize the following text"
local avante_translate = "Translate this into Chinese, but keep any code blocks inside intact"
local avante_explain_code = "Explain the following code"
local avante_complete_code = "Complete the following codes written in " .. vim.bo.filetype
local avante_add_docstring = "Add docstring to the following codes"
local avante_fix_bugs = "Fix the bugs inside the following codes if any"
local avante_add_tests = "Implement tests for the following code"

local M = {}
function M.avante()
	local map = {
		["nv|<leader>qg"] = map_callback(function()
				require("avante.api").ask({ question = avante_grammar_correction })
			end)
			:with_noremap()
			:with_silent()
			:with_desc("avante: Grammar Correction(ask)"),
		["nv|<leader>qk"] = map_callback(function()
				require("avante.api").ask({ question = avante_keywords })
			end)
			:with_noremap()
			:with_silent()
			:with_desc("avante: Keywords(ask)"),
		["nv|<leader>ql"] = map_callback(function()
				require("avante.api").ask({ question = avante_code_readability_analysis })
			end)
			:with_noremap()
			:with_silent()
			:with_desc("avante: Code Readability Analysis(ask)"),
		["nv|<leader>qo"] = map_callback(function()
				require("avante.api").ask({ question = avante_optimize_code })
			end)
			:with_noremap()
			:with_silent()
			:with_desc("avante: Optimize Code(ask)"),
		["nv|<leader>qm"] = map_callback(function()
				require("avante.api").ask({ question = avante_summarize })
			end)
			:with_noremap()
			:with_silent()
			:with_desc("avante: Summarize Text(ask)"),
		["nv|<leader>qn"] = map_callback(function()
				require("avante.api").ask({ question = avante_translate })
			end)
			:with_noremap()
			:with_silent()
			:with_desc("avante: Translate Text(ask)"),
		["nv|<leader>qx"] = map_callback(function()
				require("avante.api").ask({ question = avante_explain_code })
			end)
			:with_noremap()
			:with_silent()
			:with_desc("avante: Explain Code(ask)"),
		["nv|<leader>qc"] = map_callback(function()
				require("avante.api").ask({ question = avante_complete_code })
			end)
			:with_noremap()
			:with_silent()
			:with_desc("avante: Complete Code(ask)"),
		["nv|<leader>qd"] = map_callback(function()
				require("avante.api").ask({ question = avante_add_docstring })
			end)
			:with_noremap()
			:with_silent()
			:with_desc("avante: Docstring(ask)"),
		["nv|<leader>qb"] = map_callback(function()
				require("avante.api").ask({ question = avante_fix_bugs })
			end)
			:with_noremap()
			:with_silent()
			:with_desc("avante: Fi Bugs(ask)"),
		["nv|<leader>qu"] = map_callback(function()
				require("avante.api").ask({ question = avante_add_tests })
			end)
			:with_noremap()
			:with_silent()
			:with_desc("avante: Add Tests(ask)"),
		["v|<leader>qG"] = map_callback(function()
				prefill_edit_window(avante_grammar_correction)
			end)
			:with_noremap()
			:with_silent()
			:with_desc("avante: Grammar Correction"),
		["v|<leader>qK"] = map_callback(function()
				prefill_edit_window(avante_keywords)
			end)
			:with_noremap()
			:with_silent()
			:with_desc("avante: Keywords"),
		["v|<leader>qO"] = map_callback(function()
				prefill_edit_window(avante_optimize_code)
			end)
			:with_noremap()
			:with_silent()
			:with_desc("avante: Optimize Code(edit)"),
		["v|<leader>qC"] = map_callback(function()
				prefill_edit_window(avante_complete_code)
			end)
			:with_noremap()
			:with_silent()
			:with_desc("avante: Complete Code(edit)"),
		["v|<leader>qD"] = map_callback(function()
				prefill_edit_window(avante_add_docstring)
			end)
			:with_noremap()
			:with_silent()
			:with_desc("avante: Docstring(edit)"),
		["v|<leader>qB"] = map_callback(function()
				prefill_edit_window(avante_fix_bugs)
			end)
			:with_noremap()
			:with_silent()
			:with_desc("avante: Fix Bugs(edit)"),
		["v|<leader>qU"] = map_callback(function()
				prefill_edit_window(avante_add_tests)
			end)
			:with_noremap()
			:with_silent()
			:with_desc("avante: Add Tests(edit)"),
	}

	bind.nvim_load_mapping(map)
end

return M
