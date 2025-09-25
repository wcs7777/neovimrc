return {
	"mfussenegger/nvim-dap",
	dependencies = {
		-- Required dependency for nvim-dap-ui
		"nvim-neotest/nvim-nio",
		-- Installs the debug adapters for you
		"mason-org/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		-- UI
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
	},
	event = "VeryLazy",
	config = function()
		local mason_dap = require("mason-nvim-dap")
		local dap = require("dap")
		local dapui = require("dapui")
		local virtual_text = require("nvim-dap-virtual-text")

		mason_dap.setup({
			automatic_installation = false,
			ensure_installed = {
				'python',
			},
			handlers = {
				function(config)
					-- all sources with no handler get passed here
					-- Keep original functionality
					require('mason-nvim-dap').default_setup(config)
				end,
			},
		})

		dapui.setup()
		virtual_text.setup({
			enabled = false,
			virt_text_win_col = nil,
		})

		local desc = require('user.utils').desc
		local hydra = require('user.hydras.debug')

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
			hydra:activate()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
			hydra:activate()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
			-- hydra:exit()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
			-- hydra:exit()
		end

		vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, desc("Debug Toggle breakpoint"))
		vim.keymap.set("n", "<leader>dbt", dap.toggle_breakpoint, desc("Debug Toggle breakpoint"))
		vim.keymap.set("n", "<leader>dbl", dap.list_breakpoints, desc("Debug List toggle breakpoint"))
		vim.keymap.set("n", "<leader>dbc", dap.clear_breakpoints, desc("Debug Clear toggle breakpoint"))
		vim.keymap.set("n", "<F29>", dap.continue, desc("Debug Run/Continue"))
		vim.keymap.set("n", "<leader>dbr", dap.continue, desc("Debug Run/Continue"))
		vim.keymap.set("n", "<F17>", dap.terminate, desc("Debug Terminate"))
		vim.keymap.set("n", "<leader>dbx", dap.terminate, desc("Debug Terminate"))

	end,
}
