local M = {}

M.setup = function()
  require('config.neotest.neotest').setup()
  require('config.neotest.keymaps').setup()
end

return M
