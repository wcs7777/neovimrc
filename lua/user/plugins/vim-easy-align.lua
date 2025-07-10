local function desc(text)
    return { noremap = true, silent = true, desc = text }
end

return {
    "junegunn/vim-easy-align",
    event = "VeryLazy",
    config = function()
        vim.keymap.set("v", "<leader>al", [[<Plug>(EasyAlign)]], desc("Align"))
    end,
}
