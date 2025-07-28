return {
    "https://git.sr.ht/~nedia/auto-save.nvim",
    event = { "BufReadPre" },
    opts = {
        events = { 'InsertLeave', 'TextChanged' },
        silent = true,
        save_fn = nil,
        timeout = 500,
        exclude_ft = { 'neo-tree' },
    },
    config = function(_, opts)
        local autosave = require('auto-save')
        opts.save_fn = function()
            if vim.fn.mode() == 'i' then
                return
            end
            if opts.save_cmd ~= nil then
                vim.cmd(opts.save_cmd)
            elseif opts.silent then
                vim.cmd('silent! write')
            else
                vim.cmd('write')
            end
        end
        autosave.setup(opts)
    end,
}
