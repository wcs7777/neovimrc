return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = { "BufEnter" },
    opts = {
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_c = {'filename'},
            lualine_x = {'lsp_status', 'encoding', 'fileformat', 'filetype'},
            lualine_y = {
                function()
                    local current = vim.fn.charcol('.')
                    local last = math.max(vim.fn.charcol('$') - 1, current)
                    return current .. ':' .. last
                end,
            },
            lualine_z = {
                function()
                    local current = vim.fn.line('.')
                    local last = vim.fn.line('$')
                    return current .. ':' .. last
                end,
            },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
        },
    }
}
