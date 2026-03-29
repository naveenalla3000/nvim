-- Animated cursor smear in the terminal (Neovim >= 0.10.2). Loads at startup; toggle: :SmearCursorToggle
return {
	"sphamba/smear-cursor.nvim",
	lazy = false,
	opts = {
		-- Stays readable in splits; tweak in plugin docs if you want stronger smear
		smear_between_buffers = true,
		smear_between_neighbor_lines = true,
	},
}
