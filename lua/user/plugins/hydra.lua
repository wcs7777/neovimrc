return {
	"nvimtools/hydra.nvim",
	opts = {
	},
	config = function(_, opts)
		require('hydra').setup(opts)
		require('user.hydras')
	end,
}
