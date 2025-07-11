return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
        attach_to_untracked = true,
        on_attach = function(bufnr)

            local gitsigns = require('gitsigns')

            local function desc(text)
                return {
                    noremap = true,
                    silent = true,
                    buffer = bufnr,
                    desc = text,
                }
            end

            -- Navigation
            vim.keymap.set('n', ']c', function()
                if vim.wo.diff then
                    vim.cmd.normal({']c', bang = true})
                else
                    gitsigns.nav_hunk('next')
                end
            end, desc('Next chunk'))

            vim.keymap.set('n', '[c', function()
                if vim.wo.diff then
                    vim.cmd.normal({'[c', bang = true})
                else
                    gitsigns.nav_hunk('prev')
                end
            end, desc('Previous chunk'))

            -- Actions
            vim.keymap.set('n', '<leader>gh', gitsigns.stage_hunk, desc('Git stage hunk'))
            vim.keymap.set('v', '<leader>gh', function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, desc('Git stage hunk'))
            vim.keymap.set('n', '<leader>gs', gitsigns.stage_buffer, desc('Git stage buffer'))
            vim.keymap.set('n', '<leader>gi', gitsigns.reset_buffer_index, desc('Reset buffer stage'))
            vim.keymap.set('n', '<leader>gp', gitsigns.preview_hunk, desc('Preview hunk'))
            vim.keymap.set('n', '<leader>gd', function() gitsigns.diffthis(nil, { vertical = true, split = "botright" }) end, desc('Git diffthis'))
            vim.keymap.set('n', '<leader>ga', function() gitsigns.setqflist('all') end, desc('Git list all changes'))
            vim.keymap.set('n', '<leader>gu', gitsigns.setqflist, desc('Git list changes'))
            vim.keymap.set('n', '<leader>gr', gitsigns.reset_hunk, desc('Git reset hunk'))
            vim.keymap.set('v', '<leader>gr', function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }, { greedy = false }) end, desc('Git reset hunk'))

            -- Toggles
            vim.keymap.set('n', '<leader>gtb', gitsigns.toggle_current_line_blame, desc('Git toggle current line blame'))
            vim.keymap.set('n', '<leader>gtw', gitsigns.toggle_word_diff, desc('Git toggle word diff'))
            vim.keymap.set('n', '<leader>tg', gitsigns.toggle_signs, desc('Git toggle signs'))

            -- Text object
            vim.keymap.set({'o', 'x'}, 'ih', gitsigns.select_hunk, desc('Git select hunk'))
        end
    },
    config = true,
}
