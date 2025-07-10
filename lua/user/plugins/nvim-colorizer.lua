local function desc(text)
    return { noremap = true, silent = true, desc = text }
end

return {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
        -- #feeba3
        -- #0a2
        filetypes = {
            "css",
            "scss",
            "html",
            "javascript",
            "typescript",
            "typescriptreact",
        },
    },
    config = function(_, opts)
        require("colorizer").setup(opts)
        vim.keymap.set("n", "<leader>to", function() vim.cmd("ColorizerToggle") end, desc("Toggle Colorizer"))
    end,
}
