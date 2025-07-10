return {
    "cappyzawa/trim.nvim",
    event = { "BufEnter" },
    opts = {
        ft_blocklist = { "markdown", "neo-tree" },
        patterns = {},
        trim_on_write = true,
        trim_trailing = true,
        trim_last_line = true,
        trim_first_line = true,
        highlight = false,
        notifications = false,
    },
}
