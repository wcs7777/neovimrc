return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        notifier = { enabled = true },
        picker = {
            enabled = true,
            layout = "ivy",
            win = {
                input = {
                    keys = {
                        ["<C-y>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
                    },
                },
            },
        },
        quickfile = { enabled = true },
        rename = { enabled = true },
    },
    keys = {
        { "<leader>pp", function() Snacks.picker.pick() end, desc = "Pickers" },
        { "<leader>ps", function() Snacks.picker.smart() end, desc = "Find smart" },
        { "<leader>pb", function() Snacks.picker.buffers() end, desc = "Find buffers" },
        { "<leader>pf", function() Snacks.picker.files() end, desc = "Find files" },
        { "<leader>pa", function() Snacks.picker.files({ hidden = true, ignored = true }) end, desc = "Find all files" },
        { "<leader>pg", function() Snacks.picker.git_files() end, desc = "Find git files" },
        { "<leader>pr", function() Snacks.picker.recent() end, desc = "Recent" },
        { "<leader>pka", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
        { "<leader>pkn", function() Snacks.picker.keymaps({ modes = { "n" } }) end, desc = "Keymaps normal" },
        { "<leader>pki", function() Snacks.picker.keymaps({ modes = { "i" } }) end, desc = "Keymaps insert" },
        { "<leader>pkv", function() Snacks.picker.keymaps({ modes = { "v", "x", "s" } }) end, desc = "Keymaps visual" },
        { "<leader>pko", function() Snacks.picker.keymaps({ modes = { "o" } }) end, desc = "Keymaps operator pending" },
        { "<leader>pkc", function() Snacks.picker.keymaps({ modes = { "c" } }) end, desc = "Keymaps command" },
        { "<leader>pe", function() Snacks.picker.resume() end, desc = "Resume" },
        { "<leader>pq", function() Snacks.picker.qflist() end, desc = "Quickfix list" },
        { "<leader>si", function() Snacks.picker.grep() end, desc = "Grep" },
        { "<leader>sg", function() Snacks.picker.grep_word({ search = vim.fn.input("Grep > ") }) end, desc = "Grep search" },
        { "<leader>sv", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
        { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename file" },
        { "[[", function() Snacks.picker.grep_word() end, desc = "Next reference", mode = { "n", "x" } },
        { "<leader>pld", function() Snacks.picker.lsp_definitions() end, desc = "LSP Definitions" },
        { "<leader>plD", function() Snacks.picker.lsp_declarations() end, desc = "LSP Declaration" },
        { "<leader>plr", function() Snacks.picker.lsp_references() end, desc = "LSP References" },
        { "<leader>plI", function() Snacks.picker.lsp_implementations() end, desc = "LSP Implementations" },
        { "<leader>ply", function() Snacks.picker.lsp_type_definitions() end, desc = "LSP Type definition" },
        { "<leader>pls", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
        { "<leader>plw", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
        { "<leader>plc", function() Snacks.picker.lsp_config() end, desc = "LSP Config" },
    },
    init = function ()
        vim.api.nvim_create_autocmd("User", {
            group = vim.api.nvim_create_augroup('user-snacks-toggle-plugins', { clear = true }),
            pattern = "VeryLazy",
            callback = function()
                local function desc(text)
                    return { noremap = true, silent = true, desc = text }
                end
                local function toggle_words()
                    local enable = not Snacks.words.is_enabled()
                    if enable then
                        Snacks.words.enable()
                        vim.keymap.set("n", "]]", function() Snacks.words.jump(vim.v.count1, true) end, desc("Next Reference"))
                        vim.keymap.set("n", "[[", function() Snacks.words.jump(-vim.v.count1, true) end, desc("Previous Reference"))
                    else
                        Snacks.words.disable()
                        vim.keymap.del("n", "]]", desc("Next Reference"))
                        vim.keymap.del("n", "[[", desc("Previous Reference"))
                    end
                end
                Snacks.toggle.indent():map("<leader>tin")
                Snacks.toggle.dim():map("<leader>tim")
                vim.keymap.set("n", "<leader>two", toggle_words, desc("Next Reference"))
            end,
        })
    end
}
