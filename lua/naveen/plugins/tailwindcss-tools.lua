return {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim", -- optional
        "neovim/nvim-lspconfig",     -- optional
    },
    -- Let Mason / vim.lsp enable tailwindcss; avoids deprecated require("lspconfig") path on Nvim 0.11+.
    opts = {
        server = { override = false },
    }
}
