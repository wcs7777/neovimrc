vim.g.maplocalleader = ' '
vim.g.mapleader = ' '

local tabsize = 4

vim.opt.backup = false
vim.opt.colorcolumn = { '' }
vim.opt.completeopt = { 'menuone', 'noselect' }
vim.opt.cursorline = true
vim.opt.cursorlineopt = { 'number' }
vim.opt.expandtab = false
vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
vim.opt.guicursor = { 'a:block', 'i-r:blinkon500-blinkoff500', 'o:hor50' }
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.laststatus = 3
vim.opt.linebreak = true
vim.opt.list = false
vim.opt.listchars = { tab = "» ", lead = "·", space = "·", trail = "·", nbsp = "␣" }
vim.opt.modeline = false
vim.opt.mouse = { n = true, v = true, c = true, h = true, r = true, i = false }
vim.opt.number = true
vim.opt.pumheight = 10
vim.opt.relativenumber = true
vim.opt.runtimepath:remove('/usr/share/vim/vimfiles')
vim.opt.scrolloff = 2
vim.opt.shiftwidth = tabsize
vim.opt.shortmess:append('c')
vim.opt.showmode = false
vim.opt.showtabline = 0
vim.opt.sidescrolloff = 2
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = tabsize
vim.opt.spell = false
vim.opt.spelloptions = 'camel'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = tabsize
vim.opt.termguicolors = true
vim.opt.timeout = true
vim.opt.timeoutlen = 700
vim.opt.ttimeoutlen = 50
vim.opt.undodir = os.getenv('HOME') .. '/.vim/nvim_undodir'
vim.opt.undofile = true
vim.opt.updatetime = 1000
vim.opt.wildmenu = true
vim.opt.winborder = 'none'
vim.opt.wrap = false

-- vim.opt.textwidth = 78
-- vim.opt.iskeyword:append({ '-' })

if vim.fn.executable('rg') then
	vim.opt.grepprg = 'rg --vimgrep --smart-case --hidden'
	vim.opt.grepformat = { '%f:%l:%c:%m' }
end
