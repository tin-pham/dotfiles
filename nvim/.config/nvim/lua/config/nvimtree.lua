local M = {}

function M.setup()
  require("nvim-tree").setup {
    actions = {
      open_file = {
        resize_window = true
      }
    },
    disable_netrw = true,
    hijack_netrw = true,
    update_focused_file = { enable = true, update_cwd = true },
    ignore_ft_on_setup = { "dashboard" },
    view = {
      adaptive_size = true,
      mappings = {
          list = {
            { key = "u", action = "dir_up" },
          },
        },
    },
    filters = {
      custom = { ".git" },
    },
  renderer = {
    indent_markers = { enable = true },
    root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1003), "?:gs?^??" },
    highlight_git = true,
    highlight_opened_files = "none",
    add_trailing = false,
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = { file = true, folder = true, folder_arrow = false, git = true },
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = ""
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌"
        }
      }
    }
  },
  }

      vim.api.nvim_exec([[
      function! DisableST()
        return " "
      endfunction
      au BufEnter NvimTree setlocal statusline=%!DisableST()
      ]], false)
end

return M


