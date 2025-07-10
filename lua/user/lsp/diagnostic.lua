vim.diagnostic.config({
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    -- underline = { severity = vim.diagnostic.severity.ERROR },
    underline = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = "",
            [vim.diagnostic.severity.INFO]  = " ",
        },
    },
    virtual_text = false,
})

local function toggle_virtual_text()
    local config = vim.diagnostic.config() or {}
    if not config.virtual_text then
        config.virtual_text = {
            spacing = 2,
            source = "if_many",
            prefix = "●",
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
    else
        config.virtual_text = false
    end
    vim.diagnostic.config(config)
end

local function toggle_underline()
    local config = vim.diagnostic.config() or {}
    if not config.underline then
        config.underline = true
    else
        config.underline = false
    end
    vim.diagnostic.config(config)
end

vim.keymap.set('n', '<leader>tdv', toggle_virtual_text, { noremap = true, silent = true, desc = 'Toggle diagnostics virtual text' })
vim.keymap.set('n', '<leader>tdu', toggle_underline, { noremap = true, silent = true, desc = 'Toggle diagnostics underline' })
