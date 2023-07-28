return {
  'nvim-neotest/neotest',
  dependencies = {
    'haydenmeade/neotest-jest',
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('config.neotest').setup()
  end,
}
