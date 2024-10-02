return {
	'nvimtools/none-ls.nvim',
	event = { 'BufReadPre' },
	dependencies = {
		'nvimtools/none-ls-extras.nvim',
		'gbprod/none-ls-shellcheck.nvim',
	},
}
