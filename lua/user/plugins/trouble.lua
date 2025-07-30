local desc = require('user.utils').desc
local cmd = require('user.utils').cmd

return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
        focus = false, -- Focus the window when opened
        keys = {
            j = "next",
            k = "prev",
        },
    },
    config = function(_, opts)
        local trouble = require("trouble")
        trouble.setup(opts)
        vim.keymap.set("n", "<leader>uu", cmd("Trouble"), desc("Trouble"))
        vim.keymap.set("n", "<leader>ui", function() trouble.close() end, desc("Trouble close"))
        vim.keymap.set("n", "<leader>ud", function() trouble.toggle({ mode = "diagnostics" }) end, desc("Trouble diagnostics"))
        vim.keymap.set("n", "<leader>ub", function() trouble.toggle({ mode = "diagnostics", filter = { buf = 0 } }) end, desc("Trouble buffer diagnostics"))
        vim.keymap.set("n", "<leader>uo", function() trouble.toggle({ mode = "loclist" }) end, desc("Trouble location list"))
        vim.keymap.set("n", "<leader>uq", function() trouble.toggle({ mode = "qflist" }) end, desc("Trouble quickfix"))
        vim.keymap.set("n", "<leader>ul", function() trouble.toggle({ mode = "lsp" }) end, desc("Trouble lsp"))
        vim.keymap.set("n", "<leader>uy", function() trouble.toggle({ mode = "lsp_document_symbols" }) end, desc("Trouble lsp document symbols"))
        vim.keymap.set("n", "<leader>uf", function() trouble.toggle({ mode = "lsp_definitions" }) end, desc("Trouble lsp_definitions"))
        vim.keymap.set("n", "<leader>ur", function() trouble.toggle({ mode = "lsp_references" }) end, desc("Trouble lsp_references"))
        vim.keymap.set("n", "<leader>us", function() trouble.toggle({ mode = "symbols" }) end, desc("Trouble document symbols"))
    end,
    keys = {
        { "<leader>uu", nil, desc = "Trouble" },
        { "<leader>ui", nil, desc = "Trouble close" },
        { "<leader>ud", nil, desc = "Trouble diagnostics" },
        { "<leader>ub", nil, desc = "Trouble buffer diagnostics" },
        { "<leader>uo", nil, desc = "Trouble location list" },
        { "<leader>uq", nil, desc = "Trouble quickfix" },
        { "<leader>ul", nil, desc = "Trouble lsp" },
        { "<leader>uy", nil, desc = "Trouble lsp document symbols" },
        { "<leader>uf", nil, desc = "Trouble lsp_definitions" },
        { "<leader>ur", nil, desc = "Trouble lsp_references" },
        { "<leader>us", nil, desc = "Trouble document symbols" },
    }
}
