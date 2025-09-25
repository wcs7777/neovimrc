local Hydra = require('hydra')
local cmd = require('user.utils').cmd

local hint = [[
 ^ Diff
 ^
 _<Left>_  diff get
 _<Right>_ diff put
 _<Down>_  previous change
 _<Up>_    next change
 ^
 _9_       diff this
 _8_       diff update
 _7_       diff off
 _q_       diff off all
 ^
 _<Esc>_   exit
]]

return Hydra({
    name = 'Diff',
    hint = hint,
    config = {
        color = 'pink',
        invoke_on_body = true,
        hint = {
            position = 'bottom-right',
            float_opts = {
                border = 'rounded',
            },
        },
    },
    mode = {'n'},
    body = '<leader>yi',
    heads = {

        { '<Left>',  ':diffget<CR>', { desc = 'diff get', mode = {"n", "x"} } },
        { '<Right>', ':diffput<CR>', { desc = 'diff put', mode = {"n", "x"} } },
        { '<Down>',  ']c',           { desc = 'previous change' } },
        { '<Up>',    '[c',           { desc = 'next change' } },

        { '9', ':diffthis<CR>',   { desc = 'diff this' } },
        { '8', ':diffupdate<CR>', { desc = 'diff update' } },
        { '7', ':diffoff<CR>',    { desc = 'diff off' } },
        { 'q', ':diffoff!<CR>',   { desc = 'diff off all', exit = true } },

        { '<Esc>', nil, { exit = true } },
    }
})
