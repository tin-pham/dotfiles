local M = {}

function M.setup()
	local whichkey = require('which-key')

	-- 1. Update Setup Config (window -> win)
	local conf = {
		win = {
			border = 'single',
			-- 'position' is deprecated/handled differently in v3 layouts,
			-- but usually defaults to bottom. You can customize 'layout' if needed.
		},
		icons = {
			-- Fixes the "|mini.icons| is not installed" warning by defaulting to nvim-web-devicons
			breadcrumb = '»',
			separator = '➜',
			group = '+',
		},
	}

	whichkey.setup(conf)

	-- 2. Define the new Spec (Flat list structure)
	local mappings = {
		-- Global Keys
		{ '<leader>w', '<cmd>update!<CR>', desc = 'Save' },
		{ '<leader>q', '<cmd>q!<CR>', desc = 'Quit' },
		{ '<leader>z', '<cmd>Lazy<CR>', desc = 'Lazy' },

		-- Buffer Group
		{ '<leader>b', group = 'Buffer' },
		{ '<leader>bc', '<Cmd>bd!<Cr>', desc = 'Close current buffer' },
		{ '<leader>bD', '<Cmd>%bd|e#|bd#<Cr>', desc = 'Delete all buffers' },

		-- Git Group
		{ '<leader>g', group = 'Git' },
		{ '<leader>gs', '<cmd>Neogit<CR>', desc = 'Status' },

		-- Grapple Group
		{ '<leader>m', group = 'Grapple' },
		{ '<leader>mt', '<cmd>GrappleToggle<cr>', desc = 'Toggle Tag' },
		{ '<leader>mp', '<cmd>GrapplePopup tags<cr>', desc = 'Popup' },
		{ '<leader>mw', '<cmd>GrappleCycle forward<cr>', desc = 'Cycle Forward' },
		{ '<leader>mr', '<cmd>GrappleReset<cr>', desc = 'Reset tags' },

		-- TypeScript Group
		{ '<leader>t', group = 'TypeScript' },
		{
			'<leader>tt',
			'<cmd>execute ":find " . substitute(expand("%:t:r"), "/src/", "/tests/unit/", "") . ".spec.ts"<CR>',
			desc = 'TypeScript Unit Test File',
		},
		{
			'<leader>ti',
			'<cmd>execute ":find " . substitute(expand("%:t:r"), "/src/", "/tests/integration/", "") . ".integration-spec.ts"<CR>',
			desc = 'TypeScript Integration Test File',
		},
		{
			'<leader>te',
			'<cmd>execute ":find " . substitute(expand("%:t:r"), "/src/", "/tests/e2e/", "") . ".e2e-spec.ts"<CR>',
			desc = 'TypeScript E2E Test File',
		},
		{ '<leader>tm', '<cmd>execute ":find " . expand("%:t:r") . ".mock.ts"<CR>', desc = 'TypeScript Mock File' },
		{
			'<leader>tf',
			'<cmd>execute ":find " . substitute(substitute(substitute(substitute(expand("%:t:r"), "\\.spec$", "", ""), "\\.integration-spec$", "", ""), "\\.e2e-spec$", "", ""), "\\.mock$", "", "") . ".ts"<CR>',
			desc = 'TypeScript File',
		},
	}

	-- 3. Conditional Telescope Mappings
	if PLUGINS.telescope.enabled then
		local find_mappings = {
			{ '<leader>f', group = 'Find' },
			{ '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Files' },
			{ '<leader>fd', "<cmd>lua require('utils.finder').find_dotfiles()<cr>", desc = 'Dotfiles' },
			{ '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
			{ '<leader>fo', '<cmd>Telescope oldfiles<cr>', desc = 'Old Files' },
			{ '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live Grep' },
			{ '<leader>fc', '<cmd>Telescope commands<cr>', desc = 'Commands' },
			{ '<leader>fr', '<cmd>Telescope file_browser<cr>', desc = 'Browser' },
			{ '<leader>fw', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Current Buffer' },
		}

		-- Insert find mappings into main table
		for _, map in ipairs(find_mappings) do
			table.insert(mappings, map)
		end
	end

	-- 4. Apply mappings using the new 'add' method
	whichkey.add(mappings)
end

return M
