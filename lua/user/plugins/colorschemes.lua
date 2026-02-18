local newpaper_palette = require('user.utils.palettes.newpaper')

local disable_italics = {
    'nightfox',
}
local terminal_theme = 'light'
local current_colorscheme = 'newpaper'
vim.opt.background = terminal_theme

local colorschemes = {
    {
        'yorik1984/newpaper.nvim',
        name = 'newpaper',
        opts = {
            style               = 'light',
            italic_strings      = false,
            italic_comments     = false,
            italic_doc_comments = false,
            italic_functions    = false,
            italic_variables    = false,
            hide_eob            = true,
            lightness           = 0, -- -1(all colors '#000000') to 1(all colors '#FFFFFF').
            saturation          = 0, -- from -1 to 1. Recommended value: -0.2 - 0.2
            greyscale           = false, -- 'lightness', 'average', 'luminosity', false
            colors              = newpaper_palette.custom,
            colors_advanced     = newpaper_palette.custom_advanced,
            custom_highlights   = newpaper_palette.custom_highlights,
        },
    },
    {
        'vague-theme/vague.nvim',
        name = 'vague',
        opts = {
            transparent = false,
            bold = true,
            italic = false,
        },
    },
    {
        'thesimonho/kanagawa-paper.nvim',
        name = 'kanagawa-paper',
        opts = {
            styles = {
                comment = { italic = false },
                functions = { italic = false },
                keyword = { italic = false },
                statement = { italic = false },
                type = { italic = false },
            },
        },
    },
    {
        'EdenEast/nightfox.nvim',
        name = 'nightfox',
        variants = {
            'nightfox',
            'dayfox',
            'dawnfox',
            'dushfox',
            'nordfox',
            'terafox',
            'carbonfox',
        },
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        opts = {
            no_italic = true,
        }
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        opts = {
            styles = {
                italic = false,
            },
        },
    }
}

local lazy_colorschemes = {}
local name2setup = {}
local name2variants = {}

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
    local is_current = (
        current_colorscheme:sub(1, #cs.name) == cs.name or
        cs.variants and vim.tbl_contains(cs.variants, current_colorscheme)
    )
    local enable = (function(enable_fn, name)
        return function()
            if enable_fn then
                enable_fn()
            else
                vim.cmd('colorscheme ' .. name)
            end
        end
    end)(cs.enable, is_current and current_colorscheme or cs.name)
    table.insert(lazy_colorschemes, {
        cs[1],
        name = cs.name,
        dependencies = cs.dependencies and cs.dependencies or {},
        lazy = not is_current,
        priority = is_current and 1000 or 50,
        opts = cs.opts or {},
        config = function()
            setup()
            enable()
        end,
    })
    name2setup[cs.name] = setup
    name2variants[cs.name] = cs.variants and cs.variants or {}
end

vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('user-colorscheme', { clear = true }),
    pattern = '*',
    callback = function(args)
        local name = args.match
        local setup = name2setup[name]
        if setup == nil then
            for key, value in pairs(name2setup) do
                if (
                    name:sub(1, #key) == key or
                    vim.tbl_contains(name2variants[key], name)
                ) then
                    name = key
                    setup = value
                    break
                end
            end
        end
        if setup ~= nil then
            setup()
        end
        require('nvim-web-devicons').refresh()
        require('lualine').refresh()
        if (
            (
                type(disable_italics) == 'table' and
                vim.tbl_contains(disable_italics, name)
            ) or
            disable_italics
        ) then
            local hl_groups = vim.api.nvim_get_hl(0, {})
            for hl_name, hl in pairs(hl_groups) do
                if hl.italic then
                    vim.api.nvim_set_hl(0, hl_name, vim.tbl_extend('force', hl, { italic = false }))
                end
            end
        end
    end,
})

return lazy_colorschemes
