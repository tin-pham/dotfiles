return {
  'mfussenegger/nvim-dap',
  keys = { '<leader>d' },
  dependencies = {
    'mxsdev/nvim-dap-vscode-js',
    'theHamsta/nvim-dap-virtual-text',
    'rcarriga/nvim-dap-ui',
  },
  config = function()
    require('config.dap').setup()
  end,
}
