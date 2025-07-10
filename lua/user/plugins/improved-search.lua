local function desc(text)
    return { noremap = true, silent = true, desc = text }
end

return {
	dir = "/home/wcs/local/improved-search.nvim/",
	dev = true,
	opts = {
		hlsearch = false,
	},
	config = function(_, opts)
		local search = require("improved-search")
		search.setup(opts)
		vim.keymap.set("v", "!", search.in_place, desc("Search selected text"))
		vim.keymap.set("v", "|", search.in_place_strict, desc("Search selected text strictly"))
		vim.keymap.set("n", "!", search.current_word, desc("Search current word without moving"))
	end,
}
