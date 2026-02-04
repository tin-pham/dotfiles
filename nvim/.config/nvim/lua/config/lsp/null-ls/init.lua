local M = {}

function M.setup(opts)
  local nls = require('null-ls')
  local nls_utils = require('null-ls.utils')
  local b = nls.builtins

  -- ---------------------------------------------------------------------------
  -- Environment
  -- ---------------------------------------------------------------------------
  vim.env.ESLINT_D_PPID = vim.fn.getpid()
  vim.env.ESLINT_D_MISS = 'ignore'

  -- Lock root to where Neovim was started (monorepo-safe)
  local start_dir = vim.fn.getcwd()

  -- ---------------------------------------------------------------------------
  -- ESLint helpers
  -- ---------------------------------------------------------------------------
  local eslint_files = {
    'eslint.config.mjs',
    'eslint.config.js',
    '.eslintrc',
    '.eslintrc.cjs',
    '.eslintrc.js',
    '.eslintrc.json',
  }

  local function has_eslint_config(utils)
    return utils.root_has_file(eslint_files)
  end

  local function eslint_cwd(params)
    return nls_utils.root_pattern('package.json')(params.bufname) or start_dir
  end

  -- ---------------------------------------------------------------------------
  -- Detect TypeScript errors
  -- ---------------------------------------------------------------------------
  local function has_ts_errors(bufnr)
    local diagnostics = vim.diagnostic.get(bufnr, {
      severity = vim.diagnostic.severity.ERROR,
    })

    for _, d in ipairs(diagnostics) do
      if d.source == 'tsserver' or d.source == 'ts_ls' or d.source == 'typescript' or d.source == 'vtsls' then
        return true
      end
    end

    return false
  end

  -- ---------------------------------------------------------------------------
  -- ESLint diagnostics namespace
  -- ---------------------------------------------------------------------------
  local eslint_ns = vim.api.nvim_create_namespace('eslint-diagnostics')

  -- ---------------------------------------------------------------------------
  -- Toggle ESLint diagnostics based on TS errors
  -- ---------------------------------------------------------------------------
  vim.api.nvim_create_autocmd({ 'DiagnosticChanged', 'BufEnter' }, {
    callback = function(args)
      local bufnr = args.buf or vim.api.nvim_get_current_buf()

      -- HARD GUARD: never act globally
      if type(bufnr) ~= 'number' or not vim.api.nvim_buf_is_loaded(bufnr) then
        return
      end

      -- Only JS / TS files
      local ft = vim.bo[bufnr].filetype
      if not (ft == 'javascript' or ft == 'javascriptreact' or ft == 'typescript' or ft == 'typescriptreact') then
        return
      end

      if has_ts_errors(bufnr) then
        vim.diagnostic.enable(false, {
          bufnr = bufnr,
          namespace = eslint_ns,
        })
      else
        vim.diagnostic.enable(true, {
          bufnr = bufnr,
          namespace = eslint_ns,
        })
      end
    end,
  })

  -- ---------------------------------------------------------------------------
  -- ESLint shared config
  -- ---------------------------------------------------------------------------
  local eslint_config = {
    condition = function(utils)
      return has_eslint_config(utils)
    end,
    cwd = eslint_cwd,
    diagnostics_namespace = eslint_ns,
  }

  -- ---------------------------------------------------------------------------
  -- Sources
  -- ---------------------------------------------------------------------------
  local sources = {
    -- Formatting
    b.formatting.stylua,
    b.formatting.shfmt,
    b.formatting.clang_format,
    b.formatting.sqlfluff,

    -- ADD PRETTIER for JS/TS formatting
    b.formatting.prettierd.with({
      condition = function(utils)
        -- Only use prettier if .prettierrc exists or package.json has prettier config
        return utils.root_has_file({
          '.prettierrc',
          '.prettierrc.js',
          '.prettierrc.json',
          'prettier.config.js',
        }) or utils.root_has_file_matches('package.json')
      end,
    }),

    -- Diagnostics
    require('none-ls.diagnostics.eslint_d').with({
      condition = function(utils)
        return has_eslint_config(utils)
      end,
      cwd = eslint_cwd,
      diagnostics_namespace = eslint_ns,
      method = require('null-ls').methods.DIAGNOSTICS_ON_SAVE,
      debounce = 1000,
    }),

    -- Code actions
    -- require('none-ls.code_actions.eslint_d').with(eslint_config),
    require('none-ls-shellcheck.code_actions'),

    -- Hover
    b.hover.dictionary,
  }

  -- ---------------------------------------------------------------------------
  -- Disable diagnostics for .env files
  -- ---------------------------------------------------------------------------
  vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '.env',
    callback = function()
      vim.diagnostic.disable(0)
    end,
  })

  -- ---------------------------------------------------------------------------
  -- Setup none-ls
  -- ---------------------------------------------------------------------------
  nls.setup({
    sources = sources,
    on_attach = opts.on_attach,
    root_dir = function()
      return start_dir
    end,
  })
end

return M
