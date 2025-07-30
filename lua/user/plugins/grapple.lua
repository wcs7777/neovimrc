local desc = require('user.utils').desc

return {
    "cbochs/grapple.nvim",
    dependencies = {
        { "nvim-tree/nvim-web-devicons", lazy = true },
        "folke/trouble.nvim",
    },
    opts = {
        scope = "git", -- also try out "git_branch"
        icons = true, -- setting to "true" requires "nvim-web-devicons"
        status = true,
        quick_select = "123456789",
    },
    config = function (_, opts)
        local grapple = require("grapple")
        local trouble = require("trouble")

        grapple.setup(opts)

        local function next()
            if trouble.is_open() then
                trouble.next({ jump = true })
            else
                local win_infos = vim.fn.getwininfo()
                if vim.iter(win_infos):any(function(w) return w.loclist ~= 0 end) then
                    local ok = pcall(function() vim.cmd("lnext") end)
                    if not ok then
                        vim.cmd("lfirst")
                    end
                elseif vim.iter(win_infos):any(function(w) return w.quickfix ~= 0 end) then
                    local ok = pcall(function() vim.cmd("cnext") end)
                    if not ok then
                        vim.cmd("cfirst")
                    end
                else
                    grapple.cycle_tags("next")
                end
            end
            vim.cmd("normal! zz")
        end

        local function previous()
            if trouble.is_open() then
                trouble.prev({ jump = true })
            else
                local win_infos = vim.fn.getwininfo()
                if vim.iter(win_infos):any(function(w) return w.loclist ~= 0 end) then
                    local ok = pcall(function() vim.cmd("lprevious") end)
                    if not ok then
                        vim.cmd("llast")
                    end
                elseif vim.iter(win_infos):any(function(w) return w.quickfix ~= 0 end) then
                    local ok = pcall(function() vim.cmd("cprevious") end)
                    if not ok then
                        vim.cmd("clast")
                    end
                else
                    grapple.cycle_tags("prev")
                end
            end
            vim.cmd("normal! zz")
        end

        local function grapple_to_quickfix()
            grapple.quickfix()
            vim.cmd("cclose")
            vim.cmd("Trouble quickfix")
        end

        vim.keymap.set("n", "<M-1>", function() grapple.select({ index = 1 }) end, desc("Grapple file 1"))
        vim.keymap.set("n", "<M-2>", function() grapple.cycle_tags("next", { index = 1 }) end, desc("Grapple file 2"))
        vim.keymap.set("n", "<M-3>", function() grapple.cycle_tags("next", { index = 2 }) end, desc("Grapple file 3"))
        vim.keymap.set("n", "<M-4>", function() grapple.cycle_tags("next", { index = 3 }) end, desc("Grapple file 4"))
        vim.keymap.set("n", "<M-5>", function() grapple.cycle_tags("next", { index = 4 }) end, desc("Grapple file 5"))
        vim.keymap.set("n", "<leader>hp", function() grapple.tag({ index = 1 }) end, desc("Grapple prepend file"))
        vim.keymap.set("n", "<leader>h1", function() grapple.tag({ index = 1 }) end, desc("Grapple add file index 1"))
        vim.keymap.set("n", "<leader>h2", function() grapple.tag({ index = 2 }) end, desc("Grapple add file index 2"))
        vim.keymap.set("n", "<leader>h3", function() grapple.tag({ index = 3 }) end, desc("Grapple add file index 3"))
        vim.keymap.set("n", "<leader>h4", function() grapple.tag({ index = 4 }) end, desc("Grapple add file index 4"))
        vim.keymap.set("n", "<leader>h5", function() grapple.tag({ index = 5 }) end, desc("Grapple add file index 5"))
        vim.keymap.set("n", "<leader>ha", function() grapple.tag() end, desc("Grapple append file"))
        vim.keymap.set("n", "<leader>he", function() grapple.toggle_tags() end, desc("Grapple edit list"))
        vim.keymap.set("n", "<leader>hq", grapple_to_quickfix, desc("Grapple to quickfix"))
        vim.keymap.set("n", "<M-n>", next, desc("Grapple next file"))
        vim.keymap.set("n", "<M-p>", previous, desc("Grapple previous file"))
    end,
}
