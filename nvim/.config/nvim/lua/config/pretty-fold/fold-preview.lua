local M = {}

M.setup = function()
  local fp = require('fold-preview')
  fp.setup({
    default_keybindings = true,
    border = 'rounded',
    -- another settings
  })
end

return M
