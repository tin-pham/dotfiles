local M = {}

function M.setup()
  local whichkey = require('which-key')

  local conf = {
    window = {
      border = 'single',
      position = 'bottom',
    },
  }

  local keymaps_f = nil -- File search

  if PLUGINS.telescope.enabled then
    keymaps_f = {
      name = 'Find',
      f = { '<cmd>Telescope find_files<cr>', 'Files' },
      d = { "<cmd>lua require('utils.finder').find_dotfiles()<cr>", 'Dotfiles' },
      b = { '<cmd>Telescope buffers<cr>', 'Buffers' },
      o = { '<cmd>Telescope oldfiles<cr>', 'Old Files' },
      g = { '<cmd>Telescope live_grep<cr>', 'Live Grep' },
      c = { '<cmd>Telescope commands<cr>', 'Commands' },
      r = { '<cmd>Telescope file_browser<cr>', 'Browser' },
      w = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'Current Buffer' },
      --e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    }
  end

  local opts = {
    mode = 'n', -- Normal mode
    prefix = '<leader>',
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }
  local mappings = {
    ['w'] = { '<cmd>update!<CR>', 'Save' },
    ['q'] = { '<cmd>q!<CR>', 'Quit' },
    t = {
      name = 'TypeScript',
      ['t'] = {
        '<cmd>execute ":find " . substitute(expand("%:t:r"), "/src/", "/tests/unit/", "") . ".spec.ts"<CR>',
        'TypeScript Unit Test File',
      },
      ['i'] = {
        '<cmd>execute ":find " . substitute(expand("%:t:r"), "/src/", "/tests/integration/", "") . ".integration-spec.ts"<CR>',
        'TypeScript Integration Test File',
      },
      ['e'] = {
        '<cmd>execute ":find " . substitute(expand("%:t:r"), "/src/", "/tests/e2e/", "") . ".e2e-spec.ts"<CR>',
        'TypeScript E2E Test File',
      },
      ['m'] = { '<cmd>execute ":find " . expand("%:t:r") . ".mock.ts"<CR>', 'TypeScript Mock File' },
      ['f'] = {
        '<cmd>execute ":find " . substitute(substitute(substitute(substitute(expand("%:t:r"), "\\.spec$", "", ""), "\\.integration-spec$", "", ""), "\\.e2e-spec$", "", ""), "\\.mock$", "", "") . ".ts"<CR>',
        'TypeScript File',
      },
    },
    b = {
      name = 'Buffer',
      c = { '<Cmd>bd!<Cr>', 'Close current buffer' },
      D = { '<Cmd>%bd|e#|bd#<Cr>', 'Delete all buffers' },
    },
    f = keymaps_f,
    ['z'] = { '<cmd>Lazy<CR>', 'Lazy' },
    g = {
      name = 'Git',
      s = { '<cmd>Neogit<CR>', 'Status' },
    },
    m = {
      name = 'Grapple',
      t = { '<cmd>GrappleToggle<cr>', 'Toggle Tag' },
      p = { '<cmd>GrapplePopup tags<cr>', 'Popup' },
      w = { '<cmd>GrappleCycle forward<cr>', 'Cycle Forward' },
      r = { '<cmd>GrappleReset<cr>', 'Reset tags' },
    },
  }

  whichkey.setup(conf)
  whichkey.register(mappings, opts)
end

return M
