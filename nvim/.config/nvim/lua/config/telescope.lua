local M = {}

function M.setup()
  local status_ok, telescope = pcall(require, "telescope")
  if not status_ok then return end

  local actions = require("telescope.actions")
  local sorters = require("telescope.sorters")
  local previewers = require("telescope.previewers")

  telescope.setup({
    defaults = {
      prompt_prefix = " ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = { prompt_position = "top", preview_width = 0.55, results_width = 0.8 },
        vertical = { mirror = false },
        width = 0.8,
        height = 0.8,
        preview_cutoff = 120,
      },
      -- FIXED: vimgrep_arguments handles the grep command args
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
        },
      },
      file_sorter = sorters.get_fuzzy_file,
      file_ignore_patterns = { "node_modules", "dist", "build", "yarn.lock" },
      generic_sorter = sorters.get_generic_fuzzy_sorter,
      path_display = { "truncate" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" },
    },
    
    -- FIXED: Pickers configuration
    pickers = {
      find_files = {
        -- This is where find_command actually belongs if you need to override it
        find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
      },
    },

    -- FIXED: Extensions configuration
    extensions = {
      file_browser = {
        theme = "ivy",
        hijack_netrw = true,
        mappings = {
          ["i"] = {},
          ["n"] = {},
        },
      },
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  })

  -- Load extensions safely
  pcall(telescope.load_extension, "fzf")
  pcall(telescope.load_extension, "file_browser")
end

return M
