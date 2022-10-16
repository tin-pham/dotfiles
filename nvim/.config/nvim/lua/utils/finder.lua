local M = {}

function M.find_files()
	if PLUGINS.telescope.enabled then
		local opts = {}
		local telescope = require 'telescope.builtin'

		local ok = pcall(telescope.git_files, opts)
		if not ok then
			telescope.find_files(opts)
		end
	end
end

function M.find_dotfiles()
	require('telescope.builtin').git_files {
		prompt_title = '<Dotfiles>',
		cwd = "$HOME/dotfiles"
	}
end

return M
