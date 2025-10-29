vim.opt.background = 'light'

return {
    {
        'yorik1984/newpaper.nvim',
        name = 'newpaper',
        lazy = false,
        priority = 1000,
        opts = {
            style = 'light',
            preset = {},
            hide_eob = true,
            colors = {
                white  = '#FCFBF6',
                bg     = '#FCFBF6',
                silver = '#F0EFEA',
            },
            colors_advanced = {
                active        = '#F0EFEA',
                cursor_nr_bg  = '#F7F6F1',
                linenumber_bg = '#F7F6F1',
                git_sign_bg   = '#F7F6F1',
            },
            italic_strings      = false,
            italic_comments     = false,
            italic_doc_comments = false,
            italic_functions    = false,
            italic_variables    = false,
        },
        config = function(_, opts)
            require('newpaper').setup(opts)
            vim.cmd('colorscheme newpaper')
        end,
    },
    {
        'navarasu/onedark.nvim',
        priority = 1000,
        lazy = true,
        config = function()
            require('onedark').setup {
                style = 'light'
            }
            -- Enable theme
            require('onedark').load()
        end
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        lazy = true,
        priority = 1000,
        config = function()
            require('rose-pine').setup({
                disable_italics = true,
            })
            vim.cmd('colorscheme rose-pine')
        end
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = true,
        priority = 1000,
        config = function()
            require('catppuccin').setup({
                no_italics = true,
            })
            vim.cmd('colorscheme catppuccin')
        end
    },
}
