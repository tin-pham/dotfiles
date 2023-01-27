--> Startup Screen
return {
	'goolord/alpha-nvim',
	dependencies = {
		'kyazdani42/nvim-web-devicons',
	},
	config = function()
		require('config.alpha').setup()
	end,
}
