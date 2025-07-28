vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup('user-highlight-yank', { clear = true }),
    pattern = "*",
    callback = function()
        local event = vim.v.event
        if not event.visual then
            vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
        end
    end,
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup('user-change-cwd', { clear = true }),
    pattern = "*",
    callback = function()
        vim.cmd('cd ' .. vim.fn.expand('%:h'))
    end,
})
