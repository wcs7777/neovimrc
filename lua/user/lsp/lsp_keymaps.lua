local organize_imports = function()
	vim.lsp.buf.code_action({
		context = { only = { 'source.organizeImports' } },
		apply = true,
	})
end

---@param event vim.api.keyset.create_autocmd.callback_args
return function(event)
	local client_id = event.data.client_id
	local client = vim.lsp.get_client_by_id(client_id)
	local buffer = event.buf
	local function desc(text)
		return {
			noremap = true,
			silent = true,
			buffer = event.buf,
			desc = 'LSP ' .. text,
		}
	end
	if client and client.name == 'basedpyright' then
		organize_imports = function()
			vim.cmd('LspPyrightOrganizeImports')
		end
	end
	vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({ border = 'rounded' }) end, desc('Hover information'))
	vim.keymap.set('i', '<C-k>', function() vim.lsp.buf.signature_help({ border = 'rounded' }) end, desc('Signature help'))
	vim.keymap.set('n', 'gK', function() vim.lsp.buf.signature_help({ border = 'rounded' }) end, desc('Signature help'))
	vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, desc('Rename'))
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, desc('Rename'))
	vim.keymap.set({'n', 'x'}, '<leader>ca', vim.lsp.buf.code_action, desc('Code action'))
	vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition({ loclist = false }) end, desc('Definitions'))
	vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration({ loclist = false }) end, desc('Declaration'))
	vim.keymap.set('n', 'gr', function() vim.lsp.buf.references(nil, { loclist = false }) end, desc('References'))
	vim.keymap.set('n', 'gI', function() vim.lsp.buf.implementation({ loclist = false }) end, desc('Implementations'))
	vim.keymap.set('n', 'gy', function() vim.lsp.buf.type_definition({ loclist = false }) end, desc('Type definition'))
	vim.keymap.set('n', '<leader>ls', function() vim.lsp.buf.document_symbol({ loclist = true }) end, desc('Symbols'))
	vim.keymap.set('n', '<leader>lw', function() vim.lsp.buf.workspace_symbol('', { loclist = false }) end, desc('Workspace Symbols'))
	vim.keymap.set('n', '<leader>lq', function() vim.lsp.buf.workspace_symbol(nil, { loclist = false }) end, desc('Workspace Symbols query'))
	vim.keymap.set('n', '<leader>clr', vim.lsp.codelens.run, desc('Codelens run'))
	vim.keymap.set('n', '<leader>cle', vim.lsp.codelens.refresh, desc('Codelens refresh'))
	vim.keymap.set('n', '<leader>cld', function() vim.lsp.codelens.display(vim.lsp.codelens.get(buffer), buffer, client_id) end, desc('Codelens display'))
	vim.keymap.set('n', '<leader>clc', function() vim.lsp.codelens.clear(client_id, buffer) end, desc('Codelens clear'))
	vim.keymap.set('n', '<leader>til', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buffer }), { bufnr = buffer }) end, desc('Toggle inlay hint'))
	vim.keymap.set('n', '<leader>oi', organize_imports, desc('Organize imports'))
end
