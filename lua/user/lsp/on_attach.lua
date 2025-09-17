local set_lsp_keymaps = require('user.lsp.lsp_keymaps')

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('user-lsp-attach-keymaps', { clear = true }),
    callback = function(event)
        set_lsp_keymaps(event)
    end,
})
