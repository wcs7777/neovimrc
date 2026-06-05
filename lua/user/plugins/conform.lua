local desc = require("user.utils").desc
local enabled = true

return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			css = { "prettier" },
			html = { "prettier" },
			javascript = { "prettierd", "prettier" },
			javascriptreact = { "prettierd", "prettier" },
			json = { "prettier" },
			lua = { "stylua" },
			markdown = { "prettier" },
			python = { "isort", "ruff_format", stop_at_first = false },
			sql = { "sqlfluff" },
			typescript = { "prettierd", "prettier" },
			typescriptreact = { "prettierd", "prettier" },
			xml = { "xmlstarlet" },
		},
		formatters = {
			sqlfluff = {
				command = "sqlfluff",
				args = { "format", "--dialect=sqlite", "-" },
				require_cwd = false,
			},
		},
		stop_at_first = true,
		format_on_save = function(bufnr)
			if not enabled then
				return
			end
			local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
			if vim.tbl_contains({ "sql" }, filetype) then
				return
			end
			return {
				timeout_ms = 500,
				lsp_format = "fallback", -- Fall back to LSP if the formatter isn't available
			}
		end,
	},
	config = function(_, opts)
		local conform = require("conform")
		conform.setup(opts)

		local function toggle()
			enabled = not enabled
			vim.notify("Conform format on save " .. (enabled and "enabled" or "disabled"))
		end

		local function format()
			conform.format({ async = true }, function(err)
				if err then
					vim.notify(err)
					return
				end
				local mode = vim.api.nvim_get_mode().mode
				if vim.startswith(string.lower(mode), "v") then
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
				end
			end)
		end

		vim.keymap.set({ "n", "v" }, "<leader>ft", format, desc("Format file or range"))
		vim.keymap.set("n", "<leader>tf", toggle, desc("Toggle conform format on save"))
	end,
}
