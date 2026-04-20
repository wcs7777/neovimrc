local desc = require('user.utils').desc

return {
	'nvim-treesitter/nvim-treesitter-context',
	opts = {
		max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
		mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
	},
	config = function(_, opts)
		local treesitter_context = require('treesitter-context')
		treesitter_context.setup(opts)

		local function toggle()
			local enabled = not treesitter_context.enabled()
			if enabled then
				treesitter_context.enable()
				vim.notify('treesitter-context enabled')
			else
				treesitter_context.disable()
				vim.notify('treesitter-context disabled')
			end
		end

		vim.keymap.set("n", "[x", function() treesitter_context.go_to_context(vim.v.count1) end, desc("Jump to context upwards"))
		vim.keymap.set("n", "<leader>tx", toggle, desc("Toggle treesitter-context"))
		treesitter_context.disable()
	end,
}
