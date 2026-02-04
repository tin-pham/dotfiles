local M = {}

function M.setup(opts)
	local nls = require('null-ls')
	local nls_utils = require('null-ls.utils')
	local b = nls.builtins

	vim.env.ESLINT_D_PPID = vim.fn.getpid()
	vim.env.ESLINT_D_MISS = 'ignore'

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
	-- Detect TS errors
	-- ---------------------------------------------------------------------------
	local function has_ts_errors(bufnr)
		for _, d in
			ipairs(vim.diagnostic.get(bufnr, {
				severity = vim.diagnostic.severity.ERROR,
			}))
		do
			if d.source == 'tsserver' or d.source == 'ts_ls' or d.source == 'typescript' then
				return true
			end
		end
		return false
	end

	-- ---------------------------------------------------------------------------
	-- ESLint namespace
	-- ---------------------------------------------------------------------------
	local eslint_ns = vim.api.nvim_create_namespace('eslint-diagnostics')

	-- Mark when TS diagnostics are ready
	vim.api.nvim_create_autocmd('DiagnosticChanged', {
		callback = function(args)
			local bufnr = args.buf
			for _, d in ipairs(vim.diagnostic.get(bufnr)) do
				if d.source == 'tsserver' or d.source == 'ts_ls' or d.source == 'typescript' then
					vim.b[bufnr].ts_ready = true
					return
				end
			end
		end,
	})

	-- ---------------------------------------------------------------------------
	-- Hide / show ESLint diagnostics dynamically
	-- ---------------------------------------------------------------------------
	vim.api.nvim_create_autocmd({ 'DiagnosticChanged', 'BufEnter' }, {
		callback = function(args)
			local bufnr = args.buf or vim.api.nvim_get_current_buf()
			if not vim.api.nvim_buf_is_loaded(bufnr) then
				return
			end

			local ft = vim.bo[bufnr].filetype
			if not (ft == 'javascript' or ft == 'javascriptreact' or ft == 'typescript' or ft == 'typescriptreact') then
				return
			end

			if has_ts_errors(bufnr) then
				vim.diagnostic.hide(eslint_ns, bufnr)
			else
				vim.diagnostic.show(eslint_ns, bufnr)
			end
		end,
	})

	-- ---------------------------------------------------------------------------
	-- ESLint config
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
    require('none-ls.diagnostics.eslint_d').with(vim.tbl_extend('force', eslint_config, {
  condition = function(utils)
    local bufnr = vim.api.nvim_get_current_buf()
    return has_eslint_config(utils)
      and vim.b[bufnr].ts_ready == true
  end,
})),
		b.formatting.stylua,
		b.formatting.shfmt,

		-- Diagnostics
		require('none-ls.diagnostics.eslint_d').with(eslint_config),

		-- Code actions
		require('none-ls.code_actions.eslint_d').with(eslint_config),
	}

	-- ---------------------------------------------------------------------------
	-- Setup none-ls
	-- ---------------------------------------------------------------------------
	nls.setup({
		sources = sources,
		on_attach = opts.on_attach,
    root_dir = require('lspconfig.util').root_pattern(
  'package.json',
  '.git'
),
	})
end

return M
