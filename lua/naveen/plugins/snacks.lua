-- folke/snacks.nvim — QoL utilities: https://github.com/folke/snacks.nvim
-- Run :checkhealth snacks after install. Global API: `Snacks.*` (see docs per "snack").
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		quickfile = { enabled = true },
		bufdelete = { enabled = true },
		gitbrowse = { enabled = true },
		notifier = { enabled = true, timeout = 4000 },
		picker = { enabled = true },
		words = { enabled = true },
		zen = { enabled = true },
		scratch = { enabled = true },
		scope = { enabled = true },
		-- You already use these elsewhere; keep off to avoid overlap:
		dashboard = { enabled = false },
		explorer = { enabled = false },
		indent = { enabled = false },
		input = { enabled = false },
		lazygit = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		terminal = { enabled = false },
	},
	keys = {
		-- LSP symbol list (buffer / workspace) — complements Telescope
		{
			"<leader>fo",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "Snacks: LSP symbols (this file)",
		},
		{
			"<leader>fO",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "Snacks: LSP workspace symbols",
		},
		-- Open file / selection on Git hosting site (non-git cwd / failures already notify; avoid E5108)
		{
			"<leader>go",
			function()
				local ok, err = pcall(function()
					Snacks.gitbrowse()
				end)
				if not ok then
					local msg = tostring(err or "")
					if not msg:find("__ignore__", 1, true) then
						vim.notify(msg, vim.log.levels.ERROR)
					end
				end
			end,
			desc = "Snacks: Git browse (open in browser)",
			mode = { "n", "v" },
		},
		-- Delete buffer but keep window layout (unlike :bd)
		{
			"<leader>bx",
			function()
				Snacks.bufdelete()
			end,
			desc = "Snacks: delete buffer (keep splits)",
		},
		{ "<leader>sz", function() Snacks.zen() end, desc = "Snacks: zen mode" },
		{ "<leader>sZ", function() Snacks.zen.zoom() end, desc = "Snacks: zen zoom" },
		{ "<leader>.", function() Snacks.scratch() end, desc = "Snacks: scratch buffer" },
		{
			"<leader>sn",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Snacks: notification history",
		},
		{
			"<leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Snacks: dismiss notifications",
		},
		-- LSP references (needs words.enabled + LSP)
		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Snacks: next reference",
			mode = { "n", "t" },
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Snacks: previous reference",
			mode = { "n", "t" },
		},
	},
}
