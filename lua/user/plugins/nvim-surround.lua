return {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {
    },
    config = function(_, opts)
        require("nvim-surround").setup(opts)
    end,
}
