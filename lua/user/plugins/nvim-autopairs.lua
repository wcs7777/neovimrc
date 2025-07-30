local utils = require('user.utils')
local notify = utils.notify

local desc = require('user.utils').desc

return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {},
    config = function(_, opts)
        local ap = require('nvim-autopairs')
        ap.setup(opts)
        local function toggle()
            local enable = ap.state.disabled
            local state = ""
            if enable then
                ap.enable()
                state = "enabled"
            else
                ap.disable()
                state = "disabled"
            end
            notify("autopairs " .. state)
        end
        vim.keymap.set('n', '<leader>tp', toggle, desc('Toggle auto pairs'))
    end,
    keys = {
        { '<leader>tp', nil, desc('Toggle auto pairs') },
    }
}
