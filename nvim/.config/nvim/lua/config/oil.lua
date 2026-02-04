local M = {}

function M.setup()
	require('oil').setup({
		columns = { 'icon' },
		keymaps = {
			['<C-h>'] = false,
			['<M-h>'] = 'actions.select_split',
		},
		view_options = {
			show_hidden = true,
		},
	})

	-- Open parent directory in current window
	vim.keymap.set('n', '<C-g>', require('oil').open, { desc = 'Open parent directory' })
	-- Open parent directory in floating window
	-- vim.keymap.set('n', '<C-e>', require('oil').open_float, { desc = 'Open parent directory in floating window' })
end

return M
