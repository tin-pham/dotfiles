local M = {}
function M.setup()
	local actions = require 'telescope.actions'
	local telescope = require 'telescope'
  local previewers = require 'telescope.previewers'
  local sorters = require 'telescope.sorters'

	-- Custom previewer

	telescope.setup {
		defaults = {
			mappings = {
				i = {
					['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,
          ['<C-n>'] = actions.cycle_history_next,
          ['<C-p>'] = actions.cycle_history_prev,
				}
			},
    layout_config = {
      horizontal = {prompt_position = "top", preview_width = 0.55, results_width = 0.8},
      vertical = {mirror = false},
      width = 0.8,
      height = 0.8,
      preview_cutoff = 120
    },
    find_command = {
      'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'
    },
    find_browser = {
      theme = 'ivy',
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        }
      }
    },
    prompt_prefix = " ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",

    file_sorter = sorters.get_fuzzy_file,
    file_ignore_patterns = {
      "./node_modules/*", "node_modules", "^node_modules/*", "node_modules/*", "build", "dist",
      "yarn.lock"
    },
    generic_sorter = sorters.get_generic_fuzzy_sorter,
    path_display = {},
    winblend = 0,
    border = {},
    borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    color_devicons = true,
    use_less = true,
    set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
    buffer_previewer_maker = previewers.buffer_previewer_maker,
		}
	}

 telescope.load_extension 'fzf'
 telescope.load_extension 'file_browser'
end

return M
