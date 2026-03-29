-- Clear highlight backgrounds so terminal / wallpaper shows through (set terminal transparency).
-- Commands: :TransparentEnable, :TransparentDisable, :TransparentToggle
return {
	"xiyaowong/transparent.nvim",
	lazy = false,
	opts = {
		extra_groups = {
			"NormalFloat",
			"FloatBorder",
			"NvimTreeNormal",
			"NvimTreeNormalNC",
			"NvimTreeEndOfBuffer",
			"TelescopeNormal",
			"TelescopeBorder",
		},
	},
}
