return {
	{
		'anuvyklack/pretty-fold.nvim',
		event = { 'BufReadPre' },
		dependencies = {
			'anuvyklack/fold-preview.nvim',
		},
		config = function()
			require('pretty-fold').setup()
		end,
	},
	{
		'anuvyklack/fold-preview.nvim',
		keys = { 'z' },
		dependencies = {
			'anuvyklack/keymap-amend.nvim',
			'neovim/nvim-lspconfig',
		},
		config = function()
			require('config.pretty-fold.fold-preview').setup()
		end,
	},
}
