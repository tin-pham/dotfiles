local M = {}

local nls = require('null-ls')
local nls_utils = require('null-ls.utils')
local b = nls.builtins

local with_diagnostics_code = function(builtin)
  return builtin.with({
    diagnostics_format = '#{m} [#{c}]',
  })
end

local with_root_file = function(builtin, file)
  return builtin.with({
    condition = function(utils)
      return utils.root_has_file(file)
    end,
  })
end

local sources = {
  -- formatting
  b.formatting.prettierd,
  b.formatting.eslint_d,
  b.formatting.shfmt,
  b.formatting.fixjson,
  b.formatting.clang_format,
  b.formatting.sqlfluff,
  b.formatting.stylua,

  -- diagnostics
  b.diagnostics.eslint_d,
  b.diagnostics.sqlfluff.with({ extra_args = { '--dialect', 'postgres' } }),
  with_root_file(b.diagnostics.selene, 'selene.toml'),
  with_diagnostics_code(b.diagnostics.shellcheck),

  -- code actions
  b.code_actions.eslint_d,
  --b.code_actions.gitsigns,
  --b.code_actions.gitrebase,

  -- hover
  b.hover.dictionary,
}

function M.setup(opts)
  -- Disable stuff on certain filetype
  vim.cmd([[
  augroup _env
   autocmd!
   autocmd BufEnter .env lua vim.diagnostic.disable(0)
  augroup end
]])

  nls.setup({
    -- debug = true,
    debounce = 150,
    save_after_format = false,
    sources = sources,
    on_attach = opts.on_attach,
    root_dir = nls_utils.root_pattern('.git'),
  })
end

return M
