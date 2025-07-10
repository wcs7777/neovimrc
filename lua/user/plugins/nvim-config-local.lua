return {
	"klen/nvim-config-local",
    event = 'VeryLazy',
	opts = {
		-- Config file patterns to load (lua supported)
		config_files = { ".nvim.lua" },
		-- Where the plugin keeps files data
		hashfile = vim.fn.stdpath("data") .. "/config-local",
		autocommands_create = true, -- Create autocommands (VimEnter, DirectoryChanged)
		commands_create = true,     -- Create commands (ConfigLocalSource, ConfigLocalEdit, ConfigLocalTrust, ConfigLocalDeny)
		silent = false,             -- Disable plugin messages (Config loaded/denied)
		lookup_parents = true,     -- Lookup config files in parent directories
	},
	config = function(_, opts)
		local cl = require('config-local')
		cl.setup(opts)
		cl.source()
	end,
}
