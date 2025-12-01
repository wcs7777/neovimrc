local desc = require('user.utils').desc
local cmd = require('user.utils').cmd

return {
	'nvim-treesitter/nvim-treesitter-context',
	opts = {
		max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
		mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
	},
	config = function(_, opts)
		local treesitter_context = require('treesitter-context')
		treesitter_context.setup(opts)
		vim.keymap.set("n", "[x", function() treesitter_context.go_to_context(vim.v.count1) end, desc("Jump to context upwards"))
		vim.keymap.set("n", "<leader>tx", cmd("TSContext toggle"), desc("Toggle treesitter-context"))
	end,
}
