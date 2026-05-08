-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/bashls.lua
return {
	cmd = { "bash-language-server", "start" },
	single_file_support = true,
	filetypes = { "bash", "sh", "zsh" },
}
