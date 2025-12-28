local desc = require('user.utils').desc
local auto_show = true
local auto_show_delay_ms_enabled = 250
local auto_show_delay_ms = 0

return {
    'saghen/blink.cmp',
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        completion = {
            menu = {
                auto_show = function() return auto_show end,
                auto_show_delay_ms = function() return auto_show_delay_ms end,
                border = nil,
            },
            documentation = {
                auto_show = true,
            },
        },
        keymap = {
            preset = 'default',
            ['<Tab>'] = { 'select_and_accept', 'fallback' },
            ['<Enter>'] = { 'select_and_accept', 'fallback' },
            ['<Right>'] = { 'snippet_forward', 'fallback' },
            ['<Left>'] = { 'snippet_backward', 'fallback' },
            ['<M-l>'] = { function(cmp) cmp.show({ providers = { 'lsp' } }) end },
            ['<M-s>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },
            ['<M-t>'] = { function(cmp) cmp.show({ providers = { 'path' } }) end },
            ['<M-b>'] = { function(cmp) cmp.show({ providers = { 'buffer' } }) end },
            ['<M-1>'] = { function(cmp) cmp.show({ providers = { 'lsp' } }) end },
            ['<M-2>'] = { function(cmp) cmp.show({ providers = { 'buffer' } }) end },
        },
        sources = {
            default = {
                'lsp',
                'path',
                'snippets',
                'buffer',
            },
        },
    },
    config = function(_, opts)
        require('blink.cmp').setup(opts)

        local function toggle_autoshow()
            auto_show = not auto_show
            vim.notify('Blink autoshow ' .. (auto_show and 'enabled' or 'disabled'))
        end

        local function toggle_autoshow_delay()
            local enabled = not (auto_show_delay_ms > 0)
            auto_show_delay_ms = enabled and auto_show_delay_ms_enabled or 0
            vim.notify('Blink autoshow delay ' .. (enabled and 'enabled' or 'disabled'))
        end

        local function change_autoshow_delay()
            vim.ui.input(
                {
                    prompt = 'Blink delay ms: ',
                    default = auto_show_delay_ms_enabled,
                },
                function(input)
                    auto_show_delay_ms_enabled = input or auto_show_delay_ms_enabled
                    auto_show_delay_ms = auto_show_delay_ms_enabled
                    vim.notify('Blink autoshow delay changed to ' .. auto_show_delay_ms_enabled)
                end
            )
        end

        vim.keymap.set('n', '<leader>tk', toggle_autoshow, desc('Toggle blink autoshow'))
        vim.keymap.set('n', '<leader>ty', toggle_autoshow_delay, desc('Toggle blink autoshow delay'))
        vim.keymap.set('n', '<leader>bd', change_autoshow_delay, desc('Change blink autoshow delay'))
    end,
}
