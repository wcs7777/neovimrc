return {
    'wcs7777/auto-save.nvim',
    event = { 'BufReadPre' },
    opts = {
        events = { 'InsertLeave', 'TextChanged', 'BufEnter' },
        silent = false,
        save_fn = nil,
        timeout = 3000,
        exclude_ft = { 'neo-tree' },
    },
    config = function(_, opts)
        local autosave = require('auto-save')
        ---@param bufnr integer
        opts.save_fn = function(bufnr)
            if (
                bufnr ~= vim.api.nvim_get_current_buf() or
                not vim.api.nvim_get_option_value('modified', { buf = bufnr }) or
                vim.fn.mode() == 'i'
            ) then
                return
            end
            local save_cmd = opts.save_cmd or 'write'
            if opts.silent then
                vim.cmd('silent! ' .. save_cmd)
            else
                vim.cmd(save_cmd)
            end
        end
        autosave.setup(opts)
    end,
}
