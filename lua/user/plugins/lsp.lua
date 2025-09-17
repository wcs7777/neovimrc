return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'mason-org/mason.nvim', opts = {} },
        'mason-org/mason-lspconfig.nvim',
        { 'j-hui/fidget.nvim', opts = {} },
        'saghen/blink.cmp',
        'folke/snacks.nvim',
    },
    build = { ":MasonUpdate" },
    config = function()
        require('user.lsp.on_attach')
        require('user.lsp.diagnostic')
        require('user.lsp.servers_settings')
    end,
}
