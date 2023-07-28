local M = {}

local whichkey = require('which-key')
function M.setup()
  local keymap = {
    n = {
      name = 'Neotest',
      r = { '<cmd>lua require("neotest").run.run()<CR>', 'Run nearest test' },
      d = { '<cmd>lua require("neotest").run.run({ strategy = "dap"})<CR>', 'Debug nearest' },
      R = { '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', 'Run all tests' },
    },
  }
  local opts = {
    mode = 'n',
    prefix = '<leader>',
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  }
  whichkey.register(keymap, opts)
end

return M
