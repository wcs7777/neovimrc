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
        local Snacks = require("snacks")

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

        local function normalize(path)
            return vim.fs.normalize(vim.fn.fnamemodify(path, ":p"))
        end

        local function pick_tags(pick_opts)
            pick_opts = pick_opts or {}
            local tags, err = grapple.tags({
                scope = pick_opts.scope,
                id = pick_opts.id,
            })
            if err then
                vim.notify(err, vim.log.levels.ERROR)
                return
            end
            tags = tags or {}
            if #tags == 0 then
                vim.notify("No Grapple tags in the current scope", vim.log.levels.INFO)
                return
            end
            local current_file = normalize(vim.api.nvim_buf_get_name(0))
            local longest_name = 0
            local longest_idx = 0
            local items = {}
            for i, tag in ipairs(tags) do
                local name = tag.name or ("[" .. i .. "]")
                local path = tag.path
                local full_path = normalize(path)
                local cursor = tag.cursor or { 1, 0 }
                local is_current = full_path == current_file
                local idx_text = tostring(i)
                longest_name = math.max(longest_name, #name)
                longest_idx = math.max(longest_idx, #idx_text)
                items[#items + 1] = {
                    idx = i,
                    idx_text = idx_text,
                    score = i,
                    text = table.concat({
                        idx_text,
                        name,
                        path,
                        is_current and "current" or "",
                    }, " "),
                    file = path,
                    name = name,
                    path = path,
                    full_path = full_path,
                    lnum = cursor[1],
                    col = cursor[2] + 1,
                    is_current = is_current,
                }
            end
            longest_idx = longest_idx + 1
            longest_name = longest_name + 2

            local function jump_to_index(index)
                if index < 1 or index > #tags then
                    vim.notify(("Invalid Grapple index: %d"):format(index), vim.log.levels.WARN)
                    return
                end
                grapple.select({
                    index = index,
                    scope = pick_opts.scope,
                    id = pick_opts.id,
                })
            end

            Snacks.picker({
                title = "Grapple Tags",
                items = items,
                format = function(item)
                    local ret = {}
                    if item.is_current then
                        ret[#ret + 1] = { "● ", "DiagnosticWarn" }
                    else
                        ret[#ret + 1] = { "  ", "Normal" }
                    end
                    ret[#ret + 1] = {
                        ("%" .. longest_idx .. "s"):format(item.idx_text),
                        item.is_current and "Number" or "LineNr",
                    }
                    ret[#ret + 1] = { " ", "Normal" }
                    ret[#ret + 1] = {
                        ("%-" .. longest_name .. "s"):format(item.name),
                        "SnacksPickerLabel",
                    }
                    ret[#ret + 1] = {
                        item.path,
                        item.is_current and "DiagnosticInfo" or "SnacksPickerComment",
                    }
                    return ret
                end,
                confirm = function(picker, item)
                    local query = vim.trim(picker.input.filter.pattern)
                    picker:close()
                    if query:match("^%d+$") then
                        jump_to_index(tonumber(query))
                        return
                    end
                    if item then
                        jump_to_index(item.idx)
                    end
                end,
            })
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
        vim.keymap.set("n", "<leader>ph", pick_tags, desc("Grapple tags via Snacks picker"))
        vim.keymap.set("n", "<M-n>", next, desc("Grapple next file"))
        vim.keymap.set("n", "<M-p>", previous, desc("Grapple previous file"))
    end,
}
