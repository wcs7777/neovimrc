local Hydra = require('hydra')
local dap = require("dap")
local virtual_text_enabled = false

local function input(msg)
    local value = vim.fn.input(msg)
    return value and value or nil
end

local function bp_all()
    dap.toggle_breakpoint(
        input("Condition: "),
        input("Hit: "),
        input("Log message: ")
    )
end

local function bp_cond()
    dap.toggle_breakpoint(input("Condition: "))
end

local function bp_hit()
    dap.toggle_breakpoint(nil, input("Hit: "))
end

local function bp_log_msg()
    dap.toggle_breakpoint(nil, nil, input("Log message: "))
end

local function goto_line()
    dap.goto_(tonumber(input("Line: ")))
end

local function toggle_virtual_text()
    virtual_text_enabled = not virtual_text_enabled
    require("nvim-dap-virtual-text").setup({ enabled = virtual_text_enabled })
end

local hint = [[
 ^ Debug
 ^
 _0_          toggle breakpoint
 _1_          run/continue
 _2_          pause
 _3_          restart
 _4_          run to cursor
 _5_          jump to cursor
 _6_          jump to line
 _7_          reverse continue
 _8_          %{vt} virtual text
 _9_          terminate
 ^
 _<Right>_    step over
 _<Down>_     step into
 _<Up>_       step out
 _<Left>_     step back
 ^
 _<C-Up>_     go up stack
 _<C-Down>_   go down stack
 ^
 _<M-b>_      bp (args)
 _<M-c>_      bp conditional
 _<M-h>_      bp hit
 _<M-l>_      bp log
 _<M-x>_      bp clear
 ^
 _<C-r>_      toggle REPL
 _<C-f>_      restart frame
 _<C-x>_      add execute text
 _q_          terminate
 ^
 _<Esc>_      exit
]]

return Hydra({
    name = 'Debug',
    hint = hint,
    config = {
        color = 'pink',
        invoke_on_body = true,
        hint = {
            position = 'top-right',
            float_opts = {
                border = 'rounded',
            },
            funcs = {
                vt = function()
                    return virtual_text_enabled and '[x]' or '[ ]'
                end,
            }
        },
    },
    mode = {'n'},
    body = '<leader>yd',
    heads = {

        { '0', dap.toggle_breakpoint, { desc = 'toggle breakpoint'} },
        { '1', dap.continue,          { desc = 'run/continue'} },
        { '2', dap.pause,             { desc = 'run/continue'} },
        { '3', dap.restart,           { desc = 'restart'} },
        { '4', dap.run_to_cursor,     { desc = 'run to cursor'} },
        { '5', dap.goto_,             { desc = 'jump to cursor'} },
        { '6', goto_line,             { desc = 'jump to line'} },
        { '7', dap.reverse_continue,  { desc = 'reverse continue'} },
        { '8', toggle_virtual_text,   { desc = 'toggle virtual text'} },
        { '9', dap.terminate,         { desc = 'terminate'} },

        { '<Right>',  dap.step_over, { desc = 'step over'} },
        { '<Down>',   dap.step_into, { desc = 'step into'} },
        { '<Up>',     dap.step_out,  { desc = 'step out'} },
        { '<Left>',   dap.step_back, { desc = 'step back'} },

        { '<C-Up>',   dap.up,        { desc = 'go up in current stacktrace without stepping'} },
        { '<C-Down>', dap.down,      { desc = 'go down in current stacktrace without stepping'} },

        { '<M-b>', bp_all,                { desc = 'breakpoint' } },
        { '<M-c>', bp_cond,               { desc = 'conditional breakpoint' } },
        { '<M-h>', bp_hit,                { desc = 'hit breakpoint' } },
        { '<M-l>', bp_log_msg,            { desc = 'log breakpoint' } },
        { '<M-x>', dap.clear_breakpoints, { desc = 'clear breakpoints' } },

        { '<C-r>', dap.repl.toggle,   { desc = 'toggle REPL'} },
        { '<C-f>', dap.restart_frame, { desc = 'restart current frame'} },
        { '<C-x>', dap.repl.execute,  { desc = 'add and execute text'} },
        { 'q',     dap.terminate,     { desc = 'terminate'} },

        { '<Esc>', nil, { exit = true } },
    }
})
