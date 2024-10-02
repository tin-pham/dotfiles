local api = vim.api
local g = vim.g
local opt = vim.opt
-- Remap leader and local leader to <Space>
api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })

opt.termguicolors = true -- Enable colors in terminal
opt.hlsearch = true --Set highlight on search
opt.number = true --Make line numbers default
opt.relativenumber = true --Make relative number default
opt.undofile = true --Save undo history
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case
opt.updatetime = 250 --Decrease update time
opt.signcolumn = 'yes' -- Always show sign column
opt.clipboard = 'unnamedplus' -- Access system clipboard
opt.timeoutlen = 300 -- Time in milliseconds to wait for a mapped sequence to complete
opt.laststatus = 0 -- Disable bottom status bar
opt.splitright = true -- Split right instead of left
opt.splitbelow = true -- Split below instead of top
opt.fillchars = { eob = ' ' } -- Remove tilde in empty line
opt.scrolloff = 8 -- Screensize to keep above/below the cursor
opt.sidescrolloff = 5 -- Screensize to keep left/right the cursor
opt.winbar = '%f'

opt.expandtab = true
opt.smarttab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.autoindent = true

opt.autochdir = false

--api.nvim_command('filetype plugin indent on')

api.nvim_create_autocmd('BufEnter', {
	callback = function()
		opt.formatoptions = opt.formatoptions - 'c' - 'r' - 'o'
	end,
})

-- Native Find --
-- Search reletive to current file instead of /usr/include directory
opt.path:remove('/usr/include')
opt.path:append('**')
opt.wildignorecase = true -- Search case-insentitive
-- Ignore some directory that shouldn't be searched
opt.wildignore:append('**/node_modules/*')
opt.wildignore:append('**/.git/*')
opt.wildignore:append('**/build/*')
--vim.g.completeopt = 'menu,menuone,noselect,noinsert'

-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

-- Disable automatic commenting
vim.cmd('autocmd FileType * setlocal formatoptions-=cro')
vim.cmd([[
  augroup remember_folds
    autocmd!
    au BufWinLeave ?* mkview 1
    au BufWinEnter ?* silent! loadview 1
  augroup END
]])

-- Close quickfix list after select
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'qf' },
	command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]],
})

-- Transparent background
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })
