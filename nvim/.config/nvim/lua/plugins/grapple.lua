return {
	'cbochs/grapple.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
	keys = { '<leader>m' },
	config = function()
		require('config.grapple').setup()
	end,
}
