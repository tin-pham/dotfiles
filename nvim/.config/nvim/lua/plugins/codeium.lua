--> Github Copilot Alternative
return {
	'Exafunction/codeium.vim',
	event = 'InsertEnter',
	config = function()
		vim.keymap.set('i', '<C-g>', function()
			return vim.fn['codeium#Accept']()
		end, { expr = true })
		vim.keymap.set('i', '<C-q>', function()
			return vim.fn['codeium#CycleCompletions'](1)
		end, { expr = true })
		vim.keymap.set('i', '<C-Q>', function()
			return vim.fn['codeium#CycleCompletions'](-1)
		end, { expr = true })
		vim.keymap.set('i', '<C-x>', function()
			return vim.fn['codeium#Clear']()
		end, { expr = true })
	end,
}
