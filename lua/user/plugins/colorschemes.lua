local transparent = false
local terminal_theme = 'light'
local current_colorscheme = 'newpaper'

local colorschemes = {
    {
        'yorik1984/newpaper.nvim',
        name = 'newpaper',
        opts = {
            style = terminal_theme,
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
        setup = function(opts)
            require('newpaper').setup(opts)
            vim.opt.background = opts.style
        end,
    },
    {
        'navarasu/onedark.nvim',
        name = 'onedark',
        opts = {
        },
        enable = function() require('onedark').load() end,
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        opts = {
            styles = {
                italic = false,
            },
        },
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        opts = {
            no_italics = true,
        },
    },
}

local lazy_colorschemes = {}
local name2setup = {}

for _, cs in ipairs(colorschemes) do
    local setup = (function(name, setup, opts)
        return function()
            if setup then
                setup(opts)
            else
                require(name).setup(opts)
            end
        end
    end)(cs.name, cs.setup, cs.opts or {})
    local enable = (function(enable)
        return function()
            if enable then
                enable()
            else
                vim.cmd('colorscheme ' .. cs.name)
            end
        end
    end)(cs.enable)
    local is_current = current_colorscheme:sub(1, #cs.name) == cs.name
    table.insert(lazy_colorschemes, {
        cs[1],
        name = cs.name,
        lazy = not is_current,
        priority = is_current and 1000 or 50,
        opts = cs.opts or {},
        config = function()
            setup()
            enable()
        end,
    })
    name2setup[cs.name] = setup
end

vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('user-colorscheme', { clear = true }),
    pattern = '*',
    callback = function(args)
        local setup = name2setup[args.match]
        if setup == nil then
            for key, value in pairs(name2setup) do
                if args.match:sub(1, #key) == key then
                    setup = value
                    break
                end
            end
        end
        if setup ~= nil then
            setup()
        end
        if transparent and vim.opt.background:get() == terminal_theme then
            local groups = {
                'Comment',
                'Conditional',
                'Constant',
                'CursorLine',
                'CursorLineNr',
                'EndOfBuffer',
                'Function',
                'Identifier',
                'LineNr',
                'NonText',
                'Normal',
                'NormalNC',
                'Operator',
                'PreProc',
                'Repeat',
                'SignColumn',
                'Special',
                'Statement',
                'StatusLine',
                'StatusLineNC',
                'String',
                'Structure',
                'Todo',
                'Type',
                'Underlined',
            }
            for _, name in ipairs(groups) do
                local hl = vim.api.nvim_get_hl(0, { name = name })
                if next(hl) ~= nil then
                    local new_hl = vim.tbl_extend('force', hl, { bg = 'none', ctermbg = 'none' })
                    new_hl[true] = nil
                    vim.api.nvim_set_hl(0, name, new_hl)
                end
            end
        end
    end,
})

return lazy_colorschemes
