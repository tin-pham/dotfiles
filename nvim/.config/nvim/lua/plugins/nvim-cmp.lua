return {
	'hrsh7th/nvim-cmp',
	lazy = true,
	config = function()
		require('config.cmp').setup()
	end,
	dependencies = {
		'L3MON4D3/LuaSnip',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'saadparwaiz1/cmp_luasnip',
		'hrsh7th/cmp-calc',
		'f3fora/cmp-spell',
		'hrsh7th/cmp-emoji',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-nvim-lsp-signature-help',
		{ 'tzachar/cmp-tabnine', build = './install.sh' },
		{ 'onsails/lspkind-nvim', module = { 'lspkind' } },
	},
}
