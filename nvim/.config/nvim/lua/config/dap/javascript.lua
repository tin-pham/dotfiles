local DEBUGGER_PATH = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter'

local M = {}

M.setup = function()
  require('dap-vscode-js').setup({
    --node_path = 'node', -- Path of node executable. Defaults to $NODE_PATH, and then "node"
    debugger_path = DEBUGGER_PATH, -- Path to vscode-js-debug installation.
    debugger_cmd = { 'js-debug-adapter' }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
    adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
  })

  for _, language in ipairs({ 'typescript', 'javascript' }) do
    require('dap').configurations[language] = {
      {
        name = 'Launch',
        type = 'pwa-node',
        request = 'launch',
        program = '${file}',
        rootPath = '${workspaceFolder}',
        cwd = '${workspaceFolder}',
        sourceMaps = true,
        skipFiles = { '<node_internals>/**' },
        protocol = 'inspector',
        console = 'integratedTerminal',
      },
      {
        name = 'Attach',
        type = 'pwa-node',
        request = 'attach',
        processId = require('dap.utils').pick_process,
        cwd = '${workspaceFolder}',
        rootPath = '${workspaceFolder}',
      },
      {
        name = 'Debug Jest Tests',
        type = 'pwa-node',
        request = 'launch',
        -- trace = true, -- include debugger info
        runtimeArgs = {
          './node_modules/jest/bin/jest.js',
        },
        rootPath = '${workspaceFolder}',
        cwd = '${workspaceFolder}',
        console = 'integratedTerminal',
        internalConsoleOptions = 'neverOpen',
        port = 9229,
      },
    }
  end
end

return M
