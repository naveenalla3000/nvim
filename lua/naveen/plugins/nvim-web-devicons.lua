-- Load before nvim-tree / lualine so icon highlights apply. File glyphs need a Nerd Font in the terminal.
return {
	"nvim-tree/nvim-web-devicons",
	lazy = false,
	priority = 950,
	config = function()
		require("nvim-web-devicons").setup({
			default = true,
			color_icons = true,
		})
	end,
}
