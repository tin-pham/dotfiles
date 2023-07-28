return {
  'jackMort/ChatGPT.nvim',
  config = function()
    require('config.chatgpt').setup()
  end,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
}
