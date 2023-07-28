return {
  'nvim-lualine/lualine.nvim',
  event = { 'BufReadPre' },
  dependencies = {
    'kyazdani42/nvim-web-devicons',
  },
  config = function()
    require('config.lualine').setup()
  end,
}
