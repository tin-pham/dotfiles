local M = {}

function M.setup()
  require('nvim-treesitter.configs').setup({
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = {
      'bash',
      'comment',
      'css',
      'dot',
      'gitignore',
      'html',
      'javascript',
      'jsdoc',
      'json',
      'json5',
      'lua',
      'scss',
      'sql',
      'tsx',
      'typescript',
      'vim',
      'yaml',
      'regex',
      'dockerfile',
      'graphql',
      'markdown',
      'markdown_inline',
      'proto',
    },
    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    highlight = {
      -- `false` will disable the whole extension
      enable = true,
    },
    indent = { enable = true },
    -- nvim-ts-autotag
    autotag = { enable = true },
    -- nvim-treesitter-endwise
    endwise = { enable = true },
  })
end

return M
