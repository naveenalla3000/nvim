return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
	},
	config = function()
		local cmp = require("cmp")

		local luasnip = require("luasnip")

		local lspkind = require("lspkind")

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			-- Inline preview of the selected item (e.g. full `padding-top: ;` for snippet `padt`)
			experimental = {
				ghost_text = true,
			},
			-- Keep doc panel on; narrow completion text so a side doc window usually fits.
			view = {
				docs = {
					auto_open = true,
				},
			},
			window = {
				completion = cmp.config.window.bordered(),
				-- bordered() only reads max_width / max_height (underscores), not maxwidth.
				documentation = vim.tbl_deep_extend("force", cmp.config.window.bordered(), {
					max_width = math.min(88, math.max(36, math.floor(vim.o.columns * 0.45))),
					max_height = math.floor(vim.o.lines * 0.55),
				}),
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				-- Force / pin the documentation preview if it did not open beside the menu
				["<M-p>"] = cmp.mapping.open_docs(),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				-- select = true: Enter accepts highlighted (or first) item so snippets actually insert
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),

			-- lspkind + for LuaSnip show expanded body in the menu column (full text, one line)
			formatting = {
				fields = { "abbr", "kind", "menu" },
				format = function(entry, vim_item)
					vim_item = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 26,
						ellipsis_char = "...",
						menu = {
							buffer = "[buf]",
							nvim_lsp = "[LSP]",
							luasnip = "[snip]",
							path = "[path]",
						},
					})(entry, vim_item)

					if entry.source.name == "luasnip" then
						local data = entry.completion_item.data
						if data and data.snip_id then
							local ok_snip, snip = pcall(require("luasnip").get_id_snippet, data.snip_id)
							if ok_snip and snip then
								local ok_doc, doc = pcall(function()
									return snip:get_docstring()
								end)
								if ok_doc and doc and doc ~= "" then
									local one = doc:gsub("[\r\n]+", " "):gsub("%s+", " "):match("^%s*(.-)%s*$")
									if one and vim.fn.strchars(one) > 64 then
										one = vim.fn.strcharpart(one, 0, 61) .. "..."
									end
									if one then
										vim_item.menu = string.format("%s │ %s", vim_item.menu or "", one)
									end
								end
							end
						end
					end

					return vim_item
				end,
			},
		})
	end,
}
