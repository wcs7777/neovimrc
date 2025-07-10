vim.opt.background = 'light'

return {
    {
        "yorik1984/newpaper.nvim",
        name = "newpaper",
        lazy = false,
        priority = 1000,
        opts = {
            style = "light",
            hide_eob = true,
            colors = {
                white = "#F0F0F0",
                bg = "#F0F0F0",
                disabled = '#7f7f7f',
            },
            colors_advanced = {
                booleans = '#349479',
                cursor = '#ABC2FF',
                search_bg = '#AFD7FF',
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
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
        priority = 1000,
        config = function()
            require('rose-pine').setup({
                disable_italics = true,
            })
            vim.cmd("colorscheme rose-pine")
        end
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
        priority = 1000,
        config = function()
            require('catppuccin').setup({
                no_italics = true,
            })
            vim.cmd("colorscheme catppuccin")
        end
    },
    {
        "Mofiqul/vscode.nvim",
        lazy = true,
        priority = 1000,
        config = function()
            require('vscode').setup({
                italic_comments  = true,
            })
            vim.cmd("colorscheme vscode")
        end
    },
    {
        "EdenEast/nightfox.nvim",
        lazy = true,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme nightfox")
        end
    },
}
