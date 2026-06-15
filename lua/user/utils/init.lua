local M = {}

---@param text string   Keymap description
function M.desc(text)
	return { noremap = true, silent = true, desc = text }
end

---@param command string   Command to be executed
function M.cmd(command)
	return function()
		vim.cmd(command)
	end
end

M.kkp_enabled = vim.env.KITTY_KEYBOARD_PROTOCOL == "true"
vim.g.kitty_keyboard_protocol_enabled = M.kkp_enabled

---@param key_with_kkp string   key if kitty keyboard protocol enabled
---@param fallback string   key if kitty keyboard protocol disabled
---@return string
function M.ifkkp(key_with_kkp, fallback)
	return M.kkp_enabled and key_with_kkp or fallback
end

return M
