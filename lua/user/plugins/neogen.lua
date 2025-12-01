local desc = require("user.utils").desc

return {
	"danymat/neogen",
	opts = {},
	config = function(_, opts)
		local neogen = require('neogen')
		---@param type string   func, class, type or file
		local function generate(type)
			return function()
				neogen.generate({ type = type })
			end
		end
		neogen.setup(opts)
		vim.keymap.set("n", "<leader>ncg", neogen.generate, desc("Neogen generate annotation"))
		vim.keymap.set("n", "<leader>ncc", generate("func"), desc("Neogen generate function annotation"))
		vim.keymap.set("n", "<F3>", generate("func"), desc("Neogen generate function annotation"))
		vim.keymap.set("n", "<leader>nck", generate("class"), desc("Neogen generate class annotation"))
		vim.keymap.set("n", "<leader>nct", generate("type"), desc("Neogen generate type annotation"))
		vim.keymap.set("n", "<leader>ncf", generate("file"), desc("Neogen generate file annotation"))
	end,
}
