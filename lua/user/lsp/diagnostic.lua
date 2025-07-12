local function desc(text)
    return { noremap = true, silent = true, desc = text }
end

local virtual_text = {
    spacing = 2,
    source = true,
    prefix = '●',
    format = function(diagnostic)
        local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
        }
        return diagnostic_message[diagnostic.severity]
    end,
}

local signs = {
    text = {
        [vim.diagnostic.severity.ERROR] = ' ',
        [vim.diagnostic.severity.WARN]  = ' ',
        [vim.diagnostic.severity.HINT]  = '',
        [vim.diagnostic.severity.INFO]  = ' ',
    },
}

local underline = true

vim.diagnostic.config({
    severity_sort = true,
    float = { border = 'rounded', source = true },
    underline = false,
    signs = signs,
    virtual_text = false,
})

local function toggle_virtual_text()
    local config = vim.diagnostic.config() or {}
    if not config.virtual_text then
        config.virtual_text = virtual_text
    else
        config.virtual_text = false
    end
    vim.diagnostic.config(config)
end

local function toggle_signs()
    local config = vim.diagnostic.config() or {}
    if not config.signs then
        config.signs = signs
    else
        config.signs = false
    end
    vim.diagnostic.config(config)
end

local function toggle_underline()
    local config = vim.diagnostic.config() or {}
    if not config.underline then
        config.underline = underline
    else
        config.underline = false
    end
    vim.diagnostic.config(config)
end

vim.keymap.set('n', '<leader>tdv', toggle_virtual_text, desc('Toggle diagnostics virtual text'))
vim.keymap.set('n', '<leader>tds', toggle_signs, desc('Toggle diagnostics signs'))
vim.keymap.set('n', '<leader>tdu', toggle_underline, desc('Toggle diagnostics underline'))
