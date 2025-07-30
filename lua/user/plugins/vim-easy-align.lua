local desc = require('user.utils').desc

return {
    "junegunn/vim-easy-align",
    event = "VeryLazy",
    config = function()
        vim.keymap.set("v", "<leader>al", [[<Plug>(EasyAlign)]], desc("Align"))
    end,
}
