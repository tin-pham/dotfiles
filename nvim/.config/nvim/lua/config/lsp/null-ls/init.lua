local M = {}

function M.setup(opts)
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

	-- enable eslint_d tracking for nvim is running
	vim.env.ESLINT_D_PPID = vim.fn.getpid()
	-- disable error when no eslint
	vim.env.ESLINT_D_MISS = 'ignore'

	-- Helper to conditionally register eslint handlers only if eslint is
	-- config. If eslint is not configured for a project, it just fails.
	local function has_eslint_config(utils)
		return utils.root_has_file({
			'.eslintrc',
			'.eslintrc.cjs',
			'.eslintrc.js',
			'.eslintrc.json',
			'eslint.config.cjs',
			'eslint.config.js',
			'eslint.config.mjs',
		})
	end

	local sources = {
		-- formatting
		-- b.formatting.prettierd,
		-- require("none-ls.formatting.eslint_d"),
		b.formatting.shfmt,
		b.formatting.clang_format,
		b.formatting.sqlfluff,
		b.formatting.stylua,

		-- diagnostics
		b.diagnostics.sqlfluff.with({ extra_args = { '--dialect', 'postgres' } }),
		b.diagnostics.hadolint,
		b.diagnostics.yamllint,
		require('none-ls.diagnostics.eslint_d').with({
			condition = has_eslint_config,
		}),
		with_root_file(b.diagnostics.selene, 'selene.toml'),
		require('none-ls-shellcheck.diagnostics'),
		require('none-ls-shellcheck.code_actions'),

		-- code actions
		require("none-ls.diagnostics.eslint_d").with({
      condition = has_eslint_config,
    }),

		-- hover
		b.hover.dictionary,
	}

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
