return {
    'saghen/blink.cmp',
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        completion = {
            menu = {
                auto_show = true,
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
            ['<M-l>'] = { function(cmp) cmp.show({ providers = { 'lsp' } }) end },
            ['<M-s>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },
            ['<M-t>'] = { function(cmp) cmp.show({ providers = { 'path' } }) end },
            ['<M-b>'] = { function(cmp) cmp.show({ providers = { 'buffer' } }) end },
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
}
