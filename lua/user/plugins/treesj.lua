local desc = require("user.utils").desc

return {
	"Wansmer/treesj",
	opts = {
		use_default_keymaps = false,
	},
	config = function(_, opts)
		local treesj = require("treesj")
		treesj.setup(opts)
		vim.keymap.set("n", "<leader>tj", treesj.toggle, desc("Split or Join code block with autodetect"))
	end,
	keys = {
		"<leader>tj",
	},
}
