--> Git
return {
	'NeogitOrg/neogit',
	cmd = 'Neogit',
	dependencies = {
		'nvim-lua/plenary.nvim', -- required
		'nvim-telescope/telescope.nvim', -- optional
		'sindrets/diffview.nvim', -- optional
		'ibhagwan/fzf-lua', -- optional
	},
	config = function()
		require('config.neogit').setup()
	end,
}
