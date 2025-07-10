return {
    "https://git.sr.ht/~nedia/auto-save.nvim",
    event = { "BufReadPre" },
    opts = {
        events = { 'InsertLeave' },
        silent = false,
        save_cmd = 'update',
        timeout = 5000,
        exclude_ft = { 'neo-tree' },
    },
}
