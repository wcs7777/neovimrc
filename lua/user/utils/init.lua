local M = {}

---@param text string   Keymap description
function M.desc(text)
    return { noremap = true, silent = true, desc = text }
end

---@param command string   Command to be executed
function M.cmd(command)
    return function() vim.cmd(command) end
end

return M
