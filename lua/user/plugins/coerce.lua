return {
    "gregorias/coerce.nvim",
    tag = 'v4.1.0',
    opts = {
        default_mode_keymap_prefixes = {
            normal_mode = "<leader>ck",
            motion_mode = "gcr",
            visual_mode = "<leader>ck",
        },
    },
    config = function (_, opts)
        require("coerce").setup(opts)
        require("coerce").register_case({
            keymap = "l",
            case = function(str)
                return vim.fn.tolower(str)
            end,
            description = "lowercase",
        })
    end,
}
