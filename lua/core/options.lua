local global = require("core.global")

local function load_options()
	local global_local = {
		termguicolors = true,
		hidden = true,
		autoread = true,
		autowrite = true,
		-- back, swap file settings
		undofile = true,
		backup = false,
		writebackup = false,
		swapfile = false,
		-- use relative line number
		number = true,
		relativenumber = true,
		signcolumn = "yes",
		-- bell settings
		errorbells = true,
		visualbell = true,
		-- CRLF
		fileformats = "unix,mac,dos",
		-- use magic
		magic = true,
		-- virtual cursor in visual block mode
		virtualedit = "block",
		-- encoding setting
		encoding = "utf-8",
		-- clipboard setting
		-- clipboard = 'unnamedplus',
		-- wildchar settings
		wildignorecase = true,
		wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.tif,*.tiff,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
		-- backup settings
		sessionoptions = "buffers,curdir,help,tabpages,winsize",
		viewoptions = "folds,cursor,curdir,slash,unix",
		undodir = global.cache_dir .. "undo/",
		-- directory = global.cache_dir .. "swap/",
		-- backupdir = global.cache_dir .. "backup/",
		-- viewdir = global.cache_dir .. "view/",
		-- spellfile = global.cache_dir .. "spell/en.uft-8.add",
		history = 2000,
		shada = "!,'500,<50,@100,s10,h",
		backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim",
		-- tab settings
		smarttab = true,
		shiftround = true,
		expandtab = true,
		autoindent = true,
		tabstop = 4,
		shiftwidth = 4,
		softtabstop = 4,
		-- time settings
		timeout = true,
		ttimeout = true,
		timeoutlen = 300,
		ttimeoutlen = 0,
		updatetime = 200,
		redrawtime = 1500,
		-- case settings
		ignorecase = true,
		smartcase = true,
		infercase = true,
		-- search settings
		incsearch = true,
		wrapscan = true,
		-- complete settings
		complete = ".,w,b,k",
		completeopt = "menuone,noselect",
		-- show the effects of :substitute etc.
		inccommand = "nosplit",
		-- grep settings
		grepformat = "%f:%l:%c:%m",
		grepprg = "rg --hidden --vimgrep --smart-case --",
		breakat = [[\ \	;:,!?]],
		-- move the curosr to the first non-blank of the line while page-moving
		startofline = false,
		-- split settings
		splitbelow = true,
		splitright = true,
		splitkeep = "screen",
		equalalways = false,
		switchbuf = "usetab,uselast",
		-- backspace settings
		backspace = "indent,eol,start",
		-- diff settings
		diffopt = "filler,iwhite,internal,linematch:60,algorithm:patience",
		-- jump settings
		jumpoptions = "stack",
		-- scrolloff settings
		scrolloff = 2,
		sidescrolloff = 5,
		mousescroll = "ver:3,hor:6",
		-- fold settings
		foldenable = true,
		-- 99 no fold closed, 0 to all closed, 1 to some
		foldlevelstart = 99,
		-- statusline settings
		showmode = false,
		ruler = true,
		laststatus = 2,
		shortmess = "aoOTIcF",
		-- highlight cursor position
		cursorline = true,
		cursorcolumn = true,
		showtabline = 2,
		-- page settings
		winwidth = 30,
		winminwidth = 10,
		-- height settings
		pumheight = 15,
		helpheight = 12,
		previewheight = 12,
		-- cmd settings
		showcmd = false,
		cmdheight = 2, -- 0, 1, 2
		cmdwinheight = 5,
		display = "lastline",
		-- list settings: show tab and space etc.
		list = true,
		listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←",
		-- pseudo-transparency settings
		-- pumblend = 10,
		-- winblend = 10,

		-- see https://neovim.io/doc/user/change.html#fo-table
		formatoptions = "1jcroql",

		-- wrap settings
		breakindentopt = "shift:2,min:20",
		wrap = false,
		whichwrap = "h,l,<,>,[,],~",
		linebreak = true,
		showbreak = "↳  ",
		synmaxcol = 2500,
		-- conceal settings
		conceallevel = 0,
		concealcursor = "niv",
	}
	local function isempty(s)
		return s == nil or s == ""
	end

	-- custom python provider
	local conda_prefix = os.getenv("CONDA_PREFIX")
	if not isempty(conda_prefix) then
		vim.g.python_host_prog = conda_prefix .. "/bin/python"
		vim.g.python3_host_prog = conda_prefix .. "/bin/python"
	elseif global.is_mac then
		vim.g.python_host_prog = "/usr/bin/python"
		vim.g.python3_host_prog = "/usr/local/bin/python3"
	else
		vim.g.python_host_prog = "python"
		vim.g.python3_host_prog = "python3"
	end

	for name, value in pairs(global_local) do
		vim.o[name] = value
	end

	vim.opt.mousemodel = "" -- disable right mouse
	if global.is_windows then
		vim.o.shell = "pwsh"
		vim.o.shellcmdflag =
			"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
		vim.o.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
		vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
		vim.o.shellquote = ""
		vim.o.shellxquote = ""
		-- sqlite3.dll
		vim.g.sqlite_clib_path = global.home .. "/Documents/sqlite-dll-win64-x64-3400100/sqlite3.dll"
	end
end

load_options()
