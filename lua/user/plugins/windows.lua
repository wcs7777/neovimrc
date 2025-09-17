local desc = require('user.utils').desc
local cmd = require('user.utils').cmd

return {
	"anuvyklack/windows.nvim",
	dependencies = {
		"anuvyklack/middleclass",
	},
    event = { "BufReadPre" },
	opts = {
		autowidth = {
			enable = true,
			winwidth = 5,
			filetype = {
				help = 2,
			},
		},
		ignore = {
			buftype = { "quickfix" },
			filetype = { "NvimTree", "neo-tree", "undotree", "gundo" },
		},
		animation = {
			enable = false,
			duration = 300,
			fps = 30,
			easing = "in_out_sine"
		}
	},
	config = function(_, opts)
		require("windows").setup(opts)
		vim.cmd("WindowsDisableAutowidth")
		vim.keymap.set("n", "<leader>z", cmd("WindowsMaximize"), desc("Toggle windows maximize"))
		vim.keymap.set("n", "<leader>twa", cmd("WindowsToggleAutowidth"), desc("Toggle windows auto width"))
	end,
}
