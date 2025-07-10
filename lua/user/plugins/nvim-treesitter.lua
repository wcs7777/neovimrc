return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    opts = {
        auto_install = true,
        sync_install = false,
        highlight = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>", -- set to `false` to disable one of the mappings
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<Backspace>",
            },
        },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
