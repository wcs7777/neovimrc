vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("user-highlight-yank", { clear = true }),
	pattern = "*",
	callback = function()
		local event = vim.v.event
		if not event.visual then
			vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
		end
	end,
})
vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("user-change-cwd", { clear = true }),
	pattern = "*",
	callback = function()
		vim.cmd("cd " .. vim.fn.expand("%:h"))
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("user-indent-by-file-type", { clear = true }),
	pattern = { "sql" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.expandtab = true
	end,
})

vim.api.nvim_create_autocmd("BufReadPre", {
	callback = function(args)
		local max_file_size = 10 * 1024 * 1024 -- 10 MB
		local stat = vim.uv.fs_stat(args.file)
		if not stat or stat.type ~= "file" or stat.size <= max_file_size then
			return
		end
		local size_mb = stat.size / 1024 / 1024
		local name = args.file
		local close = false
		vim.ui.select({ "Cancel", "Open" }, {
			prompt = string.format("%s is %.1f MiB. Open anyway?", name, size_mb),
		}, function(choice)
			close = choice ~= "Open"
			vim.notify(choice)
		end)
		if close then
			vim.notify("Closing file", vim.log.levels.ERROR)
			vim.schedule(function()
				vim.api.nvim_buf_delete(args.buf, { force = true })
			end)
		end
	end,
})
