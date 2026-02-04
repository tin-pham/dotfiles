local M = {}

function M.setup()
  -- Helper function for the new keymap system
  local function on_attach(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
  end

  require('nvim-tree').setup({
    on_attach = on_attach,
    actions = {
      open_file = {
        resize_window = true,
      },
      change_dir = {
        enable = false,
      },
    },
    disable_netrw = true,
    hijack_netrw = true,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = { enable = true, update_cwd = false, update_root = true },
    -- ignore_ft_on_setup = { 'dashboard' }, -- REMOVED (Deprecated)
    view = {
      adaptive_size = true,
      -- mappings = { ... }, -- REMOVED (Deprecated, moved to on_attach)
    },
    git = {
      enable = true,
      ignore = true,
    },
    filters = {
      dotfiles = false,
      custom = { '.git' }, -- Removed duplicate entry
      exclude = { '.env', '.env.local' },
    },
    renderer = {
      indent_markers = { enable = true },
      root_folder_modifier = table.concat({ ':t:gs?$?/..', string.rep(' ', 1003), '?:gs?^??' }),
      highlight_git = true,
      highlight_opened_files = 'none',
      add_trailing = false,
      icons = {
        webdev_colors = true,
        git_placement = 'before',
        padding = ' ',
        symlink_arrow = ' ➛ ',
        show = { file = true, folder = true, folder_arrow = false, git = true },
        glyphs = {
          default = '',
          symlink = '',
          folder = {
            arrow_closed = '',
            arrow_open = '',
            default = '',
            open = '',
            empty = '',
            empty_open = '',
            symlink = '',
            symlink_open = '',
          },
          git = {
            unstaged = '✗',
            staged = '✓',
            unmerged = '',
            renamed = '➜',
            untracked = '★',
            deleted = '',
            ignored = '◌',
          },
        },
      },
    },
  })

  vim.api.nvim_exec(
    [[
      function! DisableST()
        return " "
      endfunction
      au BufEnter NvimTree setlocal statusline=%!DisableST()
    ]],
    false
  )
end

return M
