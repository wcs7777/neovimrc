local M = {}

---@param message string   What will be show
---@param timeout? integer   Notification timeout in ms
function M.notify(message, timeout)
    local ok = pcall(function()
        Snacks.notifier.notify(message, "info", { timeout = timeout or 950 })
    end)
    if not ok then
        vim.notify(message, vim.log.levels.INFO)
    end
end

---@param text string   Keymap description
function M.desc(text)
    return { noremap = true, silent = true, desc = text }
end

---@param command string   Command to be executed
function M.cmd(command)
    return function() vim.cmd(command) end
end

return M
