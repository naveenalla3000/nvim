return {
    {
        'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
        config = function()
            -- Folding settings
            vim.o.foldcolumn = '1'
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            -- Keymaps for opening and closing all folds
            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

            -- Option 1: coc.nvim as LSP client
            -- Only include this if you're using coc.nvim
            -- require('ufo').setup()

            -- LSP foldingRange is merged into all clients via vim.lsp.config('*') in lsp/mason.lua.
            require('ufo').setup({
                provider_selector = function(_bufnr, _filetype, _buftype)
                    return { 'treesitter', 'indent' }
                end,
            })
        end
    }
}
