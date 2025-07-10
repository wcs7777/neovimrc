local function desc(text)
    return { noremap = true, silent = true, desc = text }
end

return {
	"nvim-pack/nvim-spectre",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		is_block_ui_break = false, -- mapping backspace and enter key to avoid ui break
	},
	config = function(_, opts)
		local spectre = require('spectre')
		spectre.setup(opts)
		vim.keymap.set("n", "<leader>tz", spectre.toggle, desc("Toggle spectre"))
		vim.keymap.set("n", "<leader>zw", function() spectre.open_visual({ select_word = true }) end, desc("Spectre: search current word"))
		vim.keymap.set("v", "<leader>zw", function() spectre.open_visual() end, desc("Spectre: search current word"))
		vim.keymap.set("n", "<leader>zb", function() spectre.open_file_search() end, desc("Spectre: search on current file"))
	end,
}
