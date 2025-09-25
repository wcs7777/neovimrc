local desc = require('user.utils').desc

return {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    enabled = true,
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()

        local set = vim.keymap.set

        --- @param dir -1|1 Direction
        local function lineAddCursor(dir)
            return function()
                local top, bot
                mc.action(function(ctx)
                    local query = { enabledCursors = true }
                    top = ctx:mainCursor() == ctx:firstCursor(query)
                    bot = ctx:mainCursor() == ctx:lastCursor(query)
                end)
                if top == bot or (top and dir == -1) or (bot and dir == 1) then
                    mc.lineAddCursor(dir, { skipEmpty = false })
                else
                    mc.deleteCursor()
                end
            end
        end

        -- Toggle cursos
        local function toggle_cursors()
            if not mc.cursorsEnabled() then
                mc.enableCursors()
            else
                mc.disableCursors()
            end
        end

        -- Line
        set("n", "<C-Up>", lineAddCursor(-1), desc("Multicursor add cursor above"))
        set("n", "<C-Down>", lineAddCursor(1), desc("Multicursor add cursor below"))

        -- Search add cursor
        set("n", "<leader>N", function() mc.searchAddCursor(1) end, desc("Multicursor add cursor and jump to next search result"))

        -- Search add all
        set("n", "<leader>S", mc.searchAllAddCursors, desc("Multicursor add cursor for all search results"))

        -- Match add cursor
        set("x", "<leader>D", function() mc.matchAddCursor(1) end, desc("Multicursor add cursor for match and go to next"))

        -- Match add all
        set("x", "<leader>S", mc.matchAllAddCursors, desc("Multicursor add cursor for all match selection"))

        -- Insert selection
        set("x", "<leader>I", mc.insertVisual, desc("Multicursor create a cursor for each line of the visual selection, and enter insert mode"))

        -- Operator
        set("n", "ga", mc.addCursorOperator, desc("Multicursor add cursor with operator"))

        -- Restore cursors
        set("n", "<leader>gv", mc.restoreCursors, desc("Multicursor restore multiple cursors"))

        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layer_set)

            -- Clear cursors
            layer_set({"n", "x"}, "<C-q>", mc.clearCursors, desc("Multicursor clear cursors"))
            layer_set({"n", "x"}, "<M-q>", mc.clearCursors, desc("Multicursor clear cursors"))
            layer_set("n", "<Esc>", mc.clearCursors, desc("Multicursor clear cursors"))

            -- Skip line
            layer_set("n", "<Up>", function() mc.lineSkipCursor(-1, { skipEmpty = false }) end, desc("Multicursor skip line above"))
            layer_set("n", "<Down>", function() mc.lineSkipCursor(1, { skipEmpty = false }) end, desc("Multicursor skip line below"))

            -- Skip match
            layer_set("x", "<Up>", function() mc.matchSkipCursor(-1) end, desc("Multicursor skip and go to previous match"))
            layer_set("x", "<Down>", function() mc.matchSkipCursor(1) end, desc("Multicursor skip and go to next match"))

            -- Toggle cursors
            layer_set("n", "z", mc.toggleCursor, desc("Multicursor toggle current cursor"))
            layer_set("n", "<C-t>", toggle_cursors, desc("Multicursor toggle cursors"))

            -- Search
            layer_set("n", "<C-m>", function() mc.searchAddCursor(-1) end, desc("Multicursor add cursor and jump to previous search result"))
            layer_set("n", "<C-n>", function() mc.searchAddCursor(1) end, desc("Multicursor add cursor and jump to next search result"))
            layer_set("n", "N", function() mc.searchSkipCursor(-1) end, desc("Multicursor jump to the previous result without adding a cursor"))
            layer_set("n", "n", function() mc.searchSkipCursor(1) end, desc("Multicursor jump to the next result without adding a cursor"))

            -- Match
            layer_set("x", "<C-e>", function() mc.matchAddCursor(-1) end, desc("Multicursor add cursor for match and go to previous"))
            layer_set("x", "<C-d>", function() mc.matchAddCursor(1) end, desc("Multicursor add cursor for match and go to next"))

            -- Add and remove cursors with control + left click.
            layer_set("n", "<C-LeftMouse>", mc.handleMouse, desc("Multicursor multicursor handle left mouse"))
            layer_set("n", "<C-LeftDrag>", mc.handleMouseDrag, desc("Multicursor multicursor handle mouse drag"))
            layer_set("n", "<C-LeftRelease>", mc.handleMouseRelease, desc("Multicursor multicursor handle mouse release"))

            -- Select a different cursor as the main one.
            layer_set({"n", "x"}, "<Left>", mc.prevCursor, desc("Multicursor previous multicursor"))
            layer_set({"n", "x"}, "<Right>", mc.nextCursor, desc("Multicursor next multicursor"))

            -- Delete the main cursor.
            layer_set({"n", "x"}, "<leader>x", mc.deleteCursor, desc("Multicursor delete multicursor"))

            -- Align cursor columns.
            layer_set("n", "<leader>ac", mc.alignCursors, desc("Multicursor align by multicursor"))

            -- Increment/decrement sequences, treaing all cursors as one sequence.
            layer_set({"n", "x"}, "g<C-a>", mc.sequenceIncrement, desc("Multicursor sequence increment"))
            layer_set({"n", "x"}, "g<C-x>", mc.sequenceDecrement, desc("Multicursor sequence decrement"))

            -- Split visual selections by regex.
            layer_set("x", "S", mc.splitCursors, desc("Multicursor split visual selections by regex"))

            -- match new cursors within visual selections by regex.
            layer_set("x", "M", mc.matchCursors, desc("Multicursor match new cursors within visual selections by regex"))

        end)

        -- Customize how cursors look.
        vim.api.nvim_set_hl(0, "MultiCursorCursor", { reverse = true })
        vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
        vim.api.nvim_set_hl(0, "MultiCursorSign", { link = "SignColumn"})
        vim.api.nvim_set_hl(0, "MultiCursorMatchPreview", { link = "Search" })
        vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { reverse = true })
        vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        vim.api.nvim_set_hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
    end
}
