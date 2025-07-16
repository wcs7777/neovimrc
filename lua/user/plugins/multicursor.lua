local function desc(text)
    return { noremap = true, silent = true, desc = text }
end

return {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    enabled = true,
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()

        local set = vim.keymap.set

        -- Enable and clear cursors using escape.
        local function enable_clear_cursors()
            if not mc.cursorsEnabled() then
                mc.enableCursors()
            else
                mc.clearCursors()
            end
        end

        --- @param dir -1|1 Direction
        local function lineAddCursor(dir)
            local top, bot
            mc.action(function(ctx)
                local query = { enabledCursors = true }
                top = ctx:mainCursor() == ctx:firstCursor(query)
                bot = ctx:mainCursor() == ctx:lastCursor(query)
            end)
            if top == bot or (top and dir == -1) or (bot and dir == 1) then
                mc.lineAddCursor(dir)
            else
                mc.deleteCursor()
            end
        end

        -- Add or skip cursor above/below the main cursor.
        set({"n", "x"}, "<C-Up>", function() mc.lineAddCursor(-1) end, desc("Multicursor add cursor above"))
        set({"n", "x"}, "<C-Down>", function() mc.lineAddCursor(1) end, desc("Multicursor add cursor below"))
        set({"n", "x"}, "<M-Up>", function() lineAddCursor(-1) end, desc("Multicursor add cursor above"))
        set({"n", "x"}, "<M-Down>", function() lineAddCursor(1) end, desc("Multicursor add cursor below"))
        set({"n", "x"}, "<leader><Up>", function() mc.lineSkipCursor(-1) end, desc("Multicursor skip line above"))
        set({"n", "x"}, "<leader><Down>", function() mc.lineSkipCursor(1) end, desc("Multicursor skip line below"))

        -- Add or skip adding a new cursor by matching word/selection
        set({"n", "x"}, "<leader>N", function() mc.matchAddCursor(-1) end, desc("Multicursor add cursor by match above"))
        set({"n", "x"}, "<leader>n", function() mc.matchAddCursor(1) end, desc("Multicursor add cursor by match below"))
        set({"n", "x"}, "<M-c>", function() mc.matchAddCursor(1) end, desc("Multicursor add cursor by match below"))
        set({"n", "x"}, "<leader>Sc", function() mc.matchSkipCursor(-1) end, desc("Multicursor skip add cursor by match above"))
        set({"n", "x"}, "<leader>sc", function() mc.matchSkipCursor(1) end, desc("Multicursor skip add cursor by match below"))

        -- Disable and enable cursors.
        set({"n", "x"}, "<leader>tm", mc.toggleCursor, desc("Multicursor toggle multicursor in line"))
        set({"n", "x"}, "<M-t>", mc.toggleCursor, desc("Multicursor toggle multicursor in line"))

        -- Pressing `gaip` will add a cursor on each line of a paragraph
        set("n", "ga", mc.addCursorOperator)

        -- bring back cursors if you accidentally clear them
        set("n", "<leader>gv", mc.restoreCursors, desc("Multicursor restore multiple cursors"))

        -- Add a cursor for all matches of cursor word/selection in the document.
        set({"n", "x"}, "<leader>A", mc.matchAllAddCursors, desc("Multicursor add multiple cursors for all word/selection"))

        -- Add a cursor to every search result in the buffer.
        set("n", "<leader>san", function() mc.searchAddCursor(1) end, desc("Multicursor add cursor and jump to next search result"))
        set("n", "<leader>sac", mc.searchAllAddCursors, desc("Multicursor add cursor for all search result"))

        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layer_set)

            -- Add and remove cursors with control + left click.
            layer_set("n", "<C-LeftMouse>", mc.handleMouse, desc("Multicursor multicursor handle left mouse"))
            layer_set("n", "<C-LeftDrag>", mc.handleMouseDrag, desc("Multicursor multicursor handle mouse drag"))
            layer_set("n", "<C-LeftRelease>", mc.handleMouseRelease, desc("Multicursor multicursor handle mouse release"))

            -- Select a different cursor as the main one.
            layer_set({"n", "x"}, "<Left>", mc.prevCursor, desc("Multicursor previous multicursor"))
            layer_set({"n", "x"}, "<Right>", mc.nextCursor, desc("Multicursor next multicursor"))

            -- Delete the main cursor.
            layer_set({"n", "x"}, "<leader>x", mc.deleteCursor, desc("Multicursor delete multicursor"))

            -- Enable and clear cursors using escape.
            layer_set({"n", "x"}, "<M-q>", enable_clear_cursors, desc("Multicursor clear multicursors"))

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
