return {
	'folke/snacks.nvim',
	lazy = false, -- MUST be eager
	priority = 1000, -- MUST load before UI plugins
	config = function()
		require('snacks').setup({})
	end,
}
