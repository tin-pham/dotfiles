return {
	'lewis6991/impatient.nvim',
	-- Module
	'nvim-lua/plenary.nvim',
	module = 'plenary',
	-- UI
	-->Colorscheme
	-- {
	--   'rose-pine/neovim',
	--   config = function()
	--     require('config.rose-pine').setup()
	--   end,
	-- },
	{
		'catppuccin/nvim',
		config = function()
			require('config.catppuccin').setup()
		end,
	},
	-- use {
	--    'shaunsingh/nord.nvim',
	--   config = function ()
	--     require('config.nord').setup()
	--   end
	-- }

	-->Better icons
	{
		'kyazdani42/nvim-web-devicons',
		module = 'nvim-web-devicons',
		config = function()
			require('config.web-devicons').setup()
		end,
	},
	-->Syntax Highlight
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = true,
		event = 'BufRead',
		build = ':TSUpdate',
		config = function()
			require('config.treesitter').setup()
		end,
	},
	-- Auto Complete

	{
		'L3MON4D3/LuaSnip',
		event = 'InsertEnter',
		dependencies = {
			'rafamadriz/friendly-snippets',
			'saadparwaiz1/cmp_luasnip',
		},
		config = function()
			require('config.luasnip').setup()
		end,
	},
	-->Autopair
	{
		'windwp/nvim-autopairs',
		module = { 'nvim-autopairs.completion.cmp', 'nvim-autopairs' },
		dependencies = 'nvim-treesitter/nvim-treesitter',
		config = function()
			require('config.autopairs').setup()
		end,
	},
	-->Autotag
	{
		'windwp/nvim-ts-autotag',
		event = 'InsertEnter',
		dependencies = 'nvim-treesitter/nvim-treesitter',
		-- This plugin enable in treesitter
	},
	-->End wise
	{
		'RRethy/nvim-treesitter-endwise',
		event = 'InsertEnter',
		dependencies = 'nvim-treesitter/nvim-treesitter',
		-- This plugin enable in treesitter
	},
	{ 'jose-elias-alvarez/typescript.nvim', module = { 'typescript' } },
	----> Trouble
	{
		'folke/trouble.nvim',
		event = 'BufReadPre',
		dependencies = 'nvim-web-devicons',
		cmd = { 'TroubleToggle', 'Trouble' },
		config = function()
			require('trouble').setup({
				use_diagnostic_signs = true,
			})
		end,
	},
	---> LSP Saga
	{
		'tami5/lspsaga.nvim',
		event = 'VimEnter',
		cmd = { 'Lspsaga' },
		config = function()
			require('config.lsp.saga').setup()
		end,
	},
	-- Addon
	--> Telescope
	{
		'nvim-telescope/telescope.nvim',
		cmd = { 'Telescope' },
		module = 'telescope',
		keys = { '<leader>f', '<leader>p' },
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-lua/popup.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
			'nvim-telescope/telescope-file-browser.nvim',
		},
		config = function()
			require('config.telescope').setup({
				background_colour = '#000000',
			})
		end,
	},
	--> Notify
	-- use({
	-- 	'rcarriga/nvim-notify',
	-- 	event = 'VimEnter',
	-- 	config = function()
	-- 		require('config.nvim-notify').setup()
	-- 		vim.notify = require('notify')
	-- 	end,
	-- })
	--> Neoscroll
	{
		'karb94/neoscroll.nvim',
		event = 'VimEnter',
		config = function()
			require('config.neoscroll').setup()
		end,
	},
	{
		'akinsho/toggleterm.nvim',
		keys = { [[<C-\>]] },
		cmd = { 'Toggleterm', 'TermExec' },
		module = { 'toggleterm', 'toggleterm.terminal' },
		config = function()
			require('config.toggleterm').setup()
		end,
	},
	-- Tweaks
	--> Whichkey
	{
		'folke/which-key.nvim',
		event = 'VimEnter',
		config = function()
			require('config.whichkey').setup()
		end,
	},
	--> Git
	{
		'NeogitOrg/neogit',
		cmd = 'Neogit',
		dependencies = 'nvim-lua/plenary.nvim',
		config = function()
			require('config.neogit').setup()
		end,
	},
	--> Better Comment
	{
		'numToStr/Comment.nvim',
		keys = { 'gc', 'gcc', 'gbc' },
		config = function()
			require('Comment').setup({})
		end,
	},
	--> Better Winbar
	{
		'fgheng/winbar.nvim',
		event = 'BufRead',
		dependencies = 'nvim-web-devicons',
		config = function()
			require('config.winbar').setup()
		end,
	},
	{
		'ahmedkhalf/project.nvim',
		event = 'BufRead',
		config = function()
			require('config.project').setup()
		end,
	},
}
