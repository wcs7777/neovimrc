-- _Util_Functions
-- _Window
-- _Cursor_movement
-- _Miscellaneous
-- _Navigation
-- _Toggle_option
-- _Text

local utils = require('user.utils')
local notify = utils.notify
local vert_column = '80'

local function desc(text)
    return { noremap = true, silent = true, desc = text }
end

local function cmd(command)
    return function() vim.cmd(command) end
end

local function print_copy_cur_file()
    vim.fn.setreg('+', vim.fn.expand('%:p'))
    print(vim.fn.expand('%:~'))
end

local function toggle_opt(option, value1, value2)
    return function()
        local current = vim.opt[option]:get()
        if value1 ~= nil then
            if type(value1) == 'string' then
                vim.opt[option] = current == value1 and value2 or value1
            else
                vim.opt[option] = vim.deep_equal(current, value1) and value2 or value1
            end
        else
            vim.opt[option] = not current
        end
    end
end

local function yank_all(register)
    local regname = register and register or '"'
    return function()
        local pos = vim.api.nvim_win_get_cursor(0)
        vim.cmd('normal! ggVG"' .. regname .. 'y')
        vim.api.nvim_win_set_cursor(0, pos)
    end
end

local function insert_blank_lines_below()
    local pos = vim.api.nvim_win_get_cursor(0)
    local total = vim.v.count1 - 1
    vim.cmd('normal! o')
    vim.cmd('normal! "_S')

    if total > 0 then
        vim.cmd('normal! ' .. total .. 'o')
    end
    vim.api.nvim_win_set_cursor(0, pos)
end

local function insert_blank_lines_above()
    local pos = vim.api.nvim_win_get_cursor(0)
    local total = vim.v.count1 - 1
    local line = pos[1] + vim.v.count1
    vim.cmd('normal! O')
    vim.cmd('normal! "_S')
    if total > 0 then
        vim.cmd('normal! ' .. total .. 'O')
    end
    vim.api.nvim_win_set_cursor(0, { line, pos[2] })
end

local function paste_without_yank(register)
    local regname = register and register or '"'
    return function()
        local reg = vim.fn.getreg(regname)
        local regtype = vim.fn.getregtype(regname)
        vim.cmd('normal! ' .. vim.v.count1 .. '"' .. regname .. 'p')
        vim.fn.setreg(regname, reg, regtype)
    end
end

local function duplicate_cur_line()
    local pos = vim.api.nvim_win_get_cursor(0)
    local regname = '"'
    local reg = vim.fn.getreg(regname)
    local regtype = vim.fn.getregtype(regname)
    vim.cmd('normal! yy' .. vim.v.count1 .. 'p')
    vim.fn.setreg(regname, reg, regtype)
    vim.api.nvim_win_set_cursor(0, { pos[1] + 1, pos[2] })
end

local function duplicate_selection()
    local regname = '"'
    local reg = vim.fn.getreg(regname)
    local regtype = vim.fn.getregtype(regname)
    vim.cmd('normal! y' .. vim.v.count1 .. 'P')
    vim.fn.setreg(regname, reg, regtype)
end

local function erase_line()
    local regname = '"'
    local reg = vim.fn.getreg(regname)
    local regtype = vim.fn.getregtype(regname)
    vim.cmd('normal! S')
    vim.fn.setreg(regname, reg, regtype)
end

local function diff_this()
    vim.cmd('diffthis')
    local path = vim.fn.expand('%')
    notify('diff this: ' .. path)
end

local function diff_off()
    vim.cmd('windo diffoff')
    local path = vim.fn.expand('%')
    notify('diff off: ' .. path)
end

local function list_lines_exceeds()
    vim.cmd([[lgrep '^.{]] .. vert_column .. [[,}$' %]])
    vim.cmd('lopen')
end

local function delete_other_buffers()
    local cur_buf = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if cur_buf ~= buf then
            vim.api.nvim_buf_delete(buf, { force = true })
        end
    end
    local cur_win = vim.api.nvim_get_current_win()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if cur_win ~= win then
            vim.api.nvim_win_close(win, true )
        end
    end
end

-- _Window
vim.keymap.set('n', '<C-h>', '<C-w>h', desc('Move to left window'))
vim.keymap.set('n', '<C-j>', '<C-w>j', desc('Move to below window'))
vim.keymap.set('n', '<C-l>', '<C-w>l', desc('Move to right window'))
vim.keymap.set('n', '<C-k>', '<C-w>k', desc('Move to above window'))
vim.keymap.set('n', '<C-Left>', cmd('vertical resize -1'), desc('Window width -1'))
vim.keymap.set('n', '<C-Right>', cmd('vertical resize +1'), desc('Window width +1'))
-- vim.keymap.set('n', '<C-Up>', cmd('resize -1'), desc('Window height -1'))
-- vim.keymap.set('n', '<C-Down>', cmd('resize +1'), desc('Window height +1'))
vim.keymap.set('n', '<leader>bo', delete_other_buffers, desc('Close all buffers but current'))
vim.keymap.set('n', '<leader>smh', '<C-w>t<C-w>H', desc('Make horizontal split vertical'))
vim.keymap.set('n', '<leader>smv', '<C-w>t<C-w>K', desc('Make vertical split horizontal'))

-- _Cursor_movement
vim.keymap.set('n', '<C-d>', '<C-d>zz', desc('Move forward 1/2 a screen and center line'))
vim.keymap.set('n', '<C-u>', '<C-u>zz', desc('Move backward 1/2 a screen and center line'))
vim.keymap.set('n', '<Down>', 'gj', desc('Visual down'))
vim.keymap.set('n', '<Up>', 'gk', desc('Visual up'))
vim.keymap.set('n', '<End>', 'g$', desc('Visual end'))
vim.keymap.set('n', '<Home>', 'g0', desc('Visual home'))
vim.keymap.set('n', 'n', 'nzzzv', desc('Go to next search result and center line'))
vim.keymap.set('n', 'N', 'Nzzzv', desc('Go to previous search result and center line'))

-- _Miscellaneous
vim.keymap.set('n', '<leader>cs', cmd('echo ""'), desc('Clear status bar'))
vim.keymap.set('n', '<leader>fc', print_copy_cur_file, desc('Copy and print current file path'))
vim.keymap.set('n', '<leader>fp', cmd('echo expand("%:~")'), desc('Print current file path'))
vim.keymap.set('n', '<leader>lv', list_lines_exceeds, desc('List lines exceeding N characters'))
vim.keymap.set('n', '<leader>qo', cmd('copen'), desc('Quickfix open'))
vim.keymap.set('n', '<leader>qc', cmd('cclose'), desc('Quickfix close'))
vim.keymap.set('n', '<leader>qlo', cmd('lopen'), desc('Loclist open'))
vim.keymap.set('n', '<leader>qlc', cmd('lclose'), desc('Loclist close'))
vim.keymap.set('n', '<leader>dt', diff_this, desc('Diff this'))
vim.keymap.set('n', '<leader>do', diff_off, desc('Diff off'))
vim.keymap.set({ 'n', 'v' }, '<leader>dp', ':diffput<CR>', desc('Diff put'))
vim.keymap.set({ 'n', 'v' }, '<leader>dg', ':diffget<CR>', desc('Diff get'))

-- _Navigation
vim.keymap.set('n', '<leader>bs', '<C-^>', desc('Buffer switching'))
vim.keymap.set('n', '<M-e>', '<C-^>', desc('Buffer switching'))

-- _Toggle_option
vim.keymap.set('n', '<leader>tv', toggle_opt('colorcolumn', {}, {vert_column}), desc('Toggle colorcolumn'))
vim.keymap.set('n', '<leader>tc', toggle_opt('cursorlineopt', {'number'}, {'both'}), desc('Toggle cursorlineopt'))
vim.keymap.set('n', '<leader>tl', toggle_opt('list'), desc('Toggle list'))
vim.keymap.set('n', '<leader>tr', toggle_opt('relativenumber'), desc('Toggle relative number'))
vim.keymap.set('n', '<leader>tsp', toggle_opt('spell'), desc('Toggle spell'))
vim.keymap.set('n', '<leader>th', toggle_opt('hlsearch'), desc('Toggle highlight search'))
vim.keymap.set('n', '<leader>twr', toggle_opt('wrap'), desc('Toggle wrap'))
vim.keymap.set('n', '<M-z>', toggle_opt('wrap'), desc('Toggle wrap'))

-- _Text
vim.keymap.set('i', '<C-BS>', '<C-\\><C-o>"_db', desc('Delete previous word'))
vim.keymap.set('i', '<C-Del>', '<C-\\><C-o>"_dw', desc('Delete next word'))
vim.keymap.set('i', '<C-H>', '<C-\\><C-o>"_db', desc('Delete previous word'))
vim.keymap.set({ 'n', 'v' }, '<leader>sp', '"+p', desc('Paste system register'))
vim.keymap.set('v', '<leader>sy', '"+y', desc('Yank to system register'))
vim.keymap.set('n', '<leader>asp', 'ggVG"+p', desc('Replace all with system register'))
vim.keymap.set('n', '<leader>asy', yank_all('+'), desc('Yank all to system register'))
vim.keymap.set({ 'n', 'v' }, '<leader>ap', 'ggVGp', desc('Replace all with default register'))
vim.keymap.set('n', '<leader>ay', yank_all('"'), desc('Yank all to default register'))
vim.keymap.set('n', '<leader>o', 'o<Esc>O', desc('Insertion mode with blank line above and below'))
vim.keymap.set('n', '<leader>k', insert_blank_lines_below, desc('Insert blank lines below'))
vim.keymap.set('n', '<leader>K', insert_blank_lines_above, desc('Insert blank lines above'))
vim.keymap.set('v', '<leader>p', paste_without_yank('"'), desc('Paste without yank'))
vim.keymap.set('v', '<leader>db', '"_d', desc('Delete to black hole register'))
vim.keymap.set('n', '<M-d>', duplicate_cur_line, desc('Duplicate current line'))
vim.keymap.set('v', '<M-d>', duplicate_selection, desc('Duplicate selection'))
vim.keymap.set('n', '<leader>dl', duplicate_cur_line, desc('Duplicate current line'))
vim.keymap.set('v', '<leader>dl', duplicate_selection, desc('Duplicate selection'))
vim.keymap.set('n', '<leader>el', erase_line, desc('Erase line'))
vim.keymap.set('n', '<leader>rg', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], desc('Replace word cursor is on globally'))
vim.keymap.set('n', '<M-k>', [[:m -2<CR>=0]], desc('Move line up'))
vim.keymap.set('n', '<M-j>', [[:m +1<CR>=0]], desc('Move line down'))
vim.keymap.set('v', '<M-k>', [[:m '<-2<CR>gv=gv]], desc('Move selection up'))
vim.keymap.set('v', '<M-j>', [[:m '>+1<CR>gv=gv]], desc('Move selection down'))
