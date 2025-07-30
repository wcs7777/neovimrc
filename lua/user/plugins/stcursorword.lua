local desc = require('user.utils').desc

return {
    "sontungexpt/stcursorword",
    event = "VeryLazy",
    opts = {
        max_word_length = 50,
        min_word_length = 3,
        highlight = {
            underline = true,
            -- bg = "#d5d5d5",
            bg = "#e0e0e0",
        },
    },
    config = function(_, opts)
        local plugin = require("stcursorword")
        plugin.setup(opts)
        vim.cmd("Cursorword disable")
        vim.keymap.set("n", "<leader>tu", function() vim.cmd("Cursorword toggle") end, desc("Toggle Cursorword"))
    end,
    keys = {
         { "<leader>tu", nil, desc = "Toggle Cursorword" },
    },
}
