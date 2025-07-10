local function desc(text)
    return { noremap = true, silent = true, desc = text }
end

local function cmd(command)
    return function() vim.cmd(command) end
end

vim.keymap.set("n", "<M-r>", cmd("source %"), desc("Source config file"))
