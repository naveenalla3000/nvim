-- Cursor-style AI in Neovim: https://github.com/yetone/avante.nvim
--
-- Setup:
--   export OPENAI_API_KEY="sk-..."   # or AVANTE_OPENAI_API_KEY (see plugin README)
--
-- First install runs `make` (uses curl/tar for prebuilt binary, or cargo if building from source).
-- Default maps use <leader>a… (Space a …): aa ask, ae edit, ar refresh, az zen, …  →  :help avante.nvim
--
-- Project hints: optional `avante.md` in repo root (see plugin README).

return {
	"yetone/avante.nvim",
	build = vim.fn.has("win32") ~= 0
			and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",
	event = "VeryLazy",
	version = false, -- README: do not use "*"
	---@type avante.Config
	opts = {
		instructions_file = "avante.md",
		provider = "openai",
		selector = {
			provider = "telescope",
		},
		input = {
			provider = "snacks",
		},
		providers = {
			openai = {
				endpoint = "https://api.openai.com/v1",
				model = "gpt-4o",
				timeout = 300000,
				extra_request_body = {
					temperature = 0.75,
					max_tokens = 8192,
				},
			},
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-telescope/telescope.nvim",
		"hrsh7th/nvim-cmp",
		"stevearc/dressing.nvim",
		"folke/snacks.nvim",
		"nvim-tree/nvim-web-devicons",
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = { insert_mode = true },
				},
			},
		},
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
