local function desc(text)
    return { noremap = true, silent = true, desc = text }
end

local function cmd(command)
    return function() vim.cmd(command) end
end

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        "s1n7ax/nvim-window-picker",
    },
    lazy = false, -- neo-tree will lazily load itself
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
        sources = {
            'filesystem',
            'buffers',
            'git_status',
            'document_symbols',
        },
        close_if_last_window = true,
        window = {
            mappings = {
                ['<cr>'] = 'open_with_window_picker',
                ['w'] = 'open',
                ['gf'] = 'focus_filesystem',
                ['gb'] = 'focus_buffers',
                ['gg'] = 'focus_git_status',
                ['gs'] = 'focus_document_symbols',
                ['Z'] = 'expand_all_nodes',
                ["h"] = 'go_up',
                ["l"] = 'go_down',
                ["d"] = 'trash',
                ["T"] = 'delete',
            },
        },
        commands = {
            focus_filesystem = cmd('Neotree focus filesystem left'),
            focus_buffers = cmd('Neotree focus buffers left'),
            focus_git_status = cmd('Neotree focus git_status left'),
            focus_document_symbols = cmd('Neotree focus document_symbols left'),
            trash = function(state)
                local inputs = require("neo-tree.ui.inputs")
                local node = state.tree:get_node()
                if node.type == "message" then
                    return
                end
                local _, name = require("neo-tree.utils").split_path(node.path)
                local msg = string.format("Are you sure you want to trash '%s'?", name)
                inputs.confirm(msg, function(confirmed)
                    if not confirmed then
                        return
                    end
                    vim.cmd("silent !trash-put " .. node.path)
                    require("neo-tree.sources.manager").refresh(state)
                end)
            end,
            trash_visual = function(state, selected_nodes)
                local inputs = require("neo-tree.ui.inputs")
                local paths_to_trash = {}
                for _, node in ipairs(selected_nodes) do
                    if node.type ~= "message" then
                        table.insert(paths_to_trash, node.path)
                    end
                end
                local msg = "Are you sure you want to trash " .. #paths_to_trash .. " items?"
                inputs.confirm(msg, function(confirmed)
                    if not confirmed then
                        return
                    end
                    for _, path in ipairs(paths_to_trash) do
                        vim.cmd("silent !trash-put " .. path)
                    end
                    require("neo-tree.sources.manager").refresh(state)
                end)
            end,
            go_up = function(state)
                local node = state.tree:get_node()
                if node.type == 'directory' and node:is_expanded() then
                    require'neo-tree.sources.filesystem'.toggle_directory(state, node)
                else
                    require'neo-tree.ui.renderer'.focus_node(state, node:get_parent_id())
                end
            end,
            go_down = function(state)
                local node = state.tree:get_node()
                if node.type == 'directory' then
                    if not node:is_expanded() then
                        require'neo-tree.sources.filesystem'.toggle_directory(state, node)
                    elseif node:has_children() then
                        require'neo-tree.ui.renderer'.focus_node(state, node:get_child_ids()[1])
                    end
                end
            end,
        },
    },
    config = function(_, opts)
        pcall(function ()
            local function on_add(path)
                vim.cmd('Neotree focus reveal left ' .. path)
            end
            local function on_move(data)
                Snacks.rename.on_rename_file(data.source, data.destination)
                on_add(data.destination)
            end
            local events = require("neo-tree.events")
            opts.event_handlers = opts.event_handlers or {}
            vim.list_extend(opts.event_handlers, {
                { event = events.FILE_ADDED, handler = on_add },
                { event = events.FILE_MOVED, handler = on_move },
                { event = events.FILE_RENAMED, handler = on_move },
            })
        end)
        require("neo-tree").setup(opts)
        vim.keymap.set('n', '-', cmd('Neotree toggle reveal left'), desc('Neotree toggle'))
        vim.keymap.set('n', '<C-_>', cmd('Neotree focus reveal left'), desc('Neotree focus'))
    end,
}
