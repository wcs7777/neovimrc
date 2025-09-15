local desc = require('user.utils').desc

return {
	"wcs7777/improved-search.nvim",
	opts = {
		hlsearch_follow = true,
	},
	config = function(_, opts)
		local search = require("improved-search")
		search.setup(opts)
		vim.keymap.set("v", "|", search.in_place_strict, desc("Search selected text strictly"))
		vim.keymap.set("v", "!", search.in_place, desc("Search selected text"))
		vim.keymap.set("n", "!", search.current_word, desc("Search current word without moving"))
	end,
}
