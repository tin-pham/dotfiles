return {
	'neovim/nvim-lspconfig',
	event = { 'BufReadPre' },
	dependencies = {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'WhoIsSethDaniel/mason-tool-installer.nvim',
		'folke/neodev.nvim',
		'RRethy/vim-illuminate',
		'nvimtools/none-ls.nvim',
		'b0o/schemastore.nvim',
	},
	config = function()
		require('config.lsp').setup()
	end,
}
