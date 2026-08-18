return function()
	local lint = require("lint")

	-- selene: stdin mode uses process CWD to find selene.toml, which may not be the nvim
	-- config dir. Pass --config explicitly so vim.yml is always found.
	lint.linters.selene.args = {
		"--display-style",
		"json",
		"--config",
		vim.fn.stdpath("config") .. "/selene.toml",
		"-",
	}

	-- markdownlint-cli2: only add the global config — in stdin mode it discovers
	-- configs upward from the process CWD, so buffers outside a project carrying
	-- its own would otherwise fall back to factory defaults (e.g. MD013 at 80).
	-- stdin mode and the parser stay upstream's; its errorformat fallback
	-- ("stdin:%l %m") keeps findings whose column is unknown (e.g. MD012).
	lint.linters["markdownlint-cli2"].args = {
		"--config",
		vim.fn.stdpath("config") .. "/.markdownlint.yml",
		"-",
	}

	lint.linters_by_ft = {
		dockerfile = { "hadolint" },
		go = { "golangcilint" },
		lua = { "selene" },
		markdown = { "markdownlint-cli2" },
		javascript = { "oxlint" },
		javascriptreact = { "oxlint" },
		nix = { "deadnix", "statix" },
		sh = { "shellcheck" },
		typescript = { "oxlint" },
		typescriptreact = { "oxlint" },
		systemd = { "systemdlint" },
		["yaml.github"] = { "actionlint" },
		zsh = { "zsh" },
	}

	vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
		group = vim.api.nvim_create_augroup("NvimLint", { clear = true }),
		callback = function()
			lint.try_lint(nil, { ignore_errors = true })
		end,
	})
end
