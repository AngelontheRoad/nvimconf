return function()
	local ftdetect = {
		name = "ftdetect",
		opts = { defer = true },
		disable = function()
			vim.api.nvim_set_option_value("filetype", "big_file_disabled_ft", { scope = "local" })
		end,
	}

	local cmp = {
		name = "nvim-cmp",
		opts = { defer = true },
		disable = function()
			require("cmp").setup.buffer({ enabled = false })
		end,
	}

	require("modules.utils").load_plugin("bigfile", {
		filesize = 1, -- size of the file in MiB
		-- pattern = { "*" }, -- autocmd pattern
		pattern = function(bufnr, filesize_mib)
			-- you can't use `nvim_buf_line_count` because this runs on BufReadPre
			-- local filetype = vim.filetype.match({ buf = bufnr })
			local file_contents = vim.fn.readfile(vim.api.nvim_buf_get_name(bufnr))
			local file_length = #file_contents
			-- avoid error on empty file
			if file_length > 0 then
				local first_line_length = #file_contents[1]
				if file_length > 10000 or first_line_length > 1000 then
					return true
				end
			end
		end, -- autocmd pattern
		features = { -- features to disable
			-- "lsp",
			-- "illuminate",
			"treesitter",
			-- "syntax",
			-- "vimopts",
			-- ftdetect,
			-- cmp,
		},
	})
end
