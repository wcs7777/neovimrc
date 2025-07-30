local notify = require('user.utils').notify
local highlight_name = 'MyVisimatchHighlight'

local desc = require('user.utils').desc

---@param color string   Hex color
---@param factor number   factor > 1.0 = lighten, 0 < factor < 1.0 = darker
---@return string
local function adjust_color(color, factor)
	local r = tonumber(color:sub(2, 3), 16)
	local g = tonumber(color:sub(4, 5), 16)
	local b = tonumber(color:sub(6, 7), 16)
	r = math.min(math.floor(r * factor), 255)
	g = math.min(math.floor(g * factor), 255)
	b = math.min(math.floor(b * factor), 255)
	return string.format('#%02x%02x%02x', r, g, b)
end

---@param highlight string  -- Name of the highlight group to adjust
---@return { bg: string, fg: string }  -- Stronger hex colors
local function stronger_highlight(highlight)
	local hl = vim.api.nvim_get_hl(0, { name = highlight })
	local hl_bg = string.format('#%06x', hl.bg)
	local hl_bg_r = tonumber(hl_bg:sub(2, 3), 16)
	local hl_bg_b = tonumber(hl_bg:sub(4, 5), 16)
	local hl_bg_g = tonumber(hl_bg:sub(6, 7), 16)
	local hl_bg_brightness = (0.299 * hl_bg_r) + (0.587 * hl_bg_g) + (0.114 * hl_bg_b)
	local bg_factor = hl_bg_brightness > 186 and 1.1 or 0.9
	return {
		bg = adjust_color(hl_bg, bg_factor),
		fg = string.format('#%06x', hl.fg),
	}
end

local function update_hightlight()
	local sh = stronger_highlight('Search')
	vim.api.nvim_set_hl(
		0,
		highlight_name,
		{
			force = true,
			bg = sh.bg,
			fg = sh.fg,
			underline = true,
		}
	)
end

return {
	'wurli/visimatch.nvim',
	opts = {
		hl_group = highlight_name,
		-- hl_group = 'Search',
		chars_lower_limit = 2,
		lines_upper_limit = 3,
		-- By default, visimatch will highlight text even if it doesn't have exactly
		-- the same spacing as the selected region. You can set this to `true` if
		-- you're not a fan of this behaviour :)
		strict_spacing = false,
		-- Visible buffers which should be highlighted. Valid options:
		-- * `'filetype'` (the default): highlight buffers with the same filetype
		-- * `'current'`: highlight matches in the current buffer only
		-- * `'all'`: highlight matches in all visible buffers
		-- * A function. This will be passed a buffer number and should return
		--   `true`/`false` to indicate whether the buffer should be highlighted.
		buffers = 'all',
		-- Case-(in)nsitivity for matches. Valid options:
		-- * `true`: matches will never be case-sensitive
		-- * `false`/`{}`: matches will always be case-sensitive
		-- * a table of filetypes to use use case-insensitive matching for.
		case_insensitive = { 'markdown', 'text', 'help' },
	},
	config = function(_, opts)
		local enabled = 'all'
		local disabled = function() return false end
		---@type string | function
		local current = enabled
		opts.buffers = current
		local visimatch = require('visimatch')
		visimatch.setup(opts)
		local function toggle()
			if current == enabled then
				current = disabled
				notify('visimatch ' .. 'disabled')
			else
				current = enabled
				notify('visimatch ' .. 'enabled')
			end
			opts.buffers = current
			visimatch.setup(opts)
		end
		vim.api.nvim_create_autocmd('ColorScheme', {
			pattern = '*',
			group = vim.api.nvim_create_augroup('visimatch-highlight-update', { clear = true }),
			desc = 'Update selected highlight group based on current colorscheme',
			callback = function()
				update_hightlight()
			end,
		})
		update_hightlight()
        vim.keymap.set('n', '<leader>tsh', toggle, desc('Toggle visimatch'))
	end,
}
