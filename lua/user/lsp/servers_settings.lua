local servers = {
    ['lua_ls'] = require('user.lsp.servers.lua_ls'),
    ['basedpyright'] = {},
    ['clangd'] = {},
    ['css_variables'] = {},
    ['cssls'] = {},
    ['cssmodules_ls'] = {},
    ['emmet_ls'] = {},
    ['html'] = {},
    ['ts_ls'] = {},
}

local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    require('blink.cmp').get_lsp_capabilities()
)

for server, config in pairs(servers) do
    config.capabilities = vim.tbl_deep_extend(
        'force',
        {},
        capabilities,
        config.capabilities or {}
    )
    if not config.capabilities.workspace then
        config.capabilities.workspace = {}
    end
    if not config.capabilities.workspace.fileOperations then
        config.capabilities.workspace.fileOperations = {
            didRename = true,
            willRename = true,
        }
    end
    vim.lsp.config(server, config)
end

require('mason-lspconfig').setup({
    ensure_installed = vim.tbl_keys(servers or {}),
    automatic_enable = true,
})
