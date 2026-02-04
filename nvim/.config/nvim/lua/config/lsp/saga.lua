local M = {}
M.setup = function()
	local saga = require('lspsaga')
	saga.setup({
		code_action_prompt = { enable = false },
		symbols_in_winbar = {
			enable = true,
		},
	})
end

return M
