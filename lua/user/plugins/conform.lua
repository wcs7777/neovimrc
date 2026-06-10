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
			prettier = {
				prepend_args = function(self, ctx)
					local global_config = vim.fn.expand("~/.config/.prettierrc.json")
					local markers = {
						".prettierrc",
						".prettierrc.json",
						".prettierrc.yml",
						".prettierrc.yaml",
						".prettierrc.json5",
						".prettierrc.js",
						".prettierrc.cjs",
						"prettier.config.js",
						"prettier.config.cjs",
					}
					local has_project_config = vim.fs.root(ctx.dirname, markers) ~= nil
					if not has_project_config then
						return { "--config", global_config }
					end
					return {}
				end,
			},
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
				timeout_ms = 5000,
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

		local function format(formatters)
			return function()
				local options = { async = true }
				if formatters then
					options["formatters"] = formatters
				end
				conform.format(options, function(err)
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
		end

		vim.keymap.set({ "n", "v" }, "<leader>ft", format(), desc("Format file or range"))
		vim.keymap.set({ "n", "v" }, "<leader>fi", format({ "injected" }), desc("Format file or range injected code"))
		vim.keymap.set("n", "<leader>tf", toggle, desc("Toggle conform format on save"))
	end,
}
