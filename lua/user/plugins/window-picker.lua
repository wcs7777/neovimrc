return {
    's1n7ax/nvim-window-picker',
    name = 'window-picker',
    event = 'VeryLazy',
    version = '2.*',
    opts = {
        selection_chars = 'ASDFGHQWERTYJKLÇ',
        picker_config = {
            handle_mouse_click = true,
        },
        highlights = {
            enabled = true,
            statusline = {
                focused = {
                    fg = '#ededed',
                    bg = '#a847ac',
                    bold = true,
                },
                unfocused = {
                    fg = '#ededed',
                    bg = '#204d72',
                    bold = true,
                },
            },
            winbar = {
                focused = {
                    fg = '#ededed',
                    bg = '#a847ac',
                    bold = true,
                },
                unfocused = {
                    fg = '#ededed',
                    bg = '#204d72',
                    bold = true,
                },
            },
        },
    },
}
