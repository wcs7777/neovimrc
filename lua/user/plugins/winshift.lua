local desc = require('user.utils').desc
local cmd = require('user.utils').cmd

return {
	"sindrets/winshift.nvim",
	opts = {},
	config = function(_, opts)
		require("winshift").setup(opts)
		vim.keymap.set("n", "<leader>wx", cmd("WinShift"), desc("Windows shift"))
		vim.keymap.set("n", "<leader>ws", cmd("WinShift swap"), desc("Windows shift swap"))
	end,
}
