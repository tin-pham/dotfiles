local M = {}

function M.setup()
	-- LSP handlers configuration
	local lsp = {
		float = {
			focusable = true,
			style = 'minimal',
			border = 'rounded',
		},
		diagnostic = {
			virtual_text = false, -- virtual_text = { spacing = 4, prefix = "●" },
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			float = {
				focusable = true,
				style = 'minimal',
				border = 'rounded',
				-- Show source in diagnostic float
				source = 'always',
				-- Custom format to prioritize errors
				format = function(diagnostic)
					-- Prioritize TS/JS errors over ESLint
					local source = diagnostic.source or 'unknown'
					if source == 'eslint' or source == 'eslint_d' then
						return string.format('[ESLint] %s', diagnostic.message)
					elseif source == 'ts_ls' or source == 'typescript' or source == 'tsserver' then
						return string.format('[TS] %s', diagnostic.message)
					end
					return string.format('[%s] %s', source, diagnostic.message)
				end,
			},
		},
	}

	-- Diagnostic signs with priority indicators
	local diagnostic_signs = {
		{ name = 'DiagnosticSignError', text = '' },
		{ name = 'DiagnosticSignWarn', text = '' },
		{ name = 'DiagnosticSignHint', text = '' },
		{ name = 'DiagnosticSignInfo', text = '' },
	}

	for _, sign in ipairs(diagnostic_signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	end

	-- Diagnostic configuration
	vim.diagnostic.config(lsp.diagnostic)

	-- Custom diagnostic handler that filters ESLint when TS has errors
	local original_handler = vim.lsp.handlers['textDocument/publishDiagnostics']
	vim.lsp.handlers['textDocument/publishDiagnostics'] = function(err, result, ctx, config)
		-- Get client name
		local client = vim.lsp.get_client_by_id(ctx.client_id)
		if not client then
			return original_handler(err, result, ctx, config)
		end

		-- If this is ESLint, check for TS errors first
		if client.name == 'null-ls' or client.name == 'eslint' or client.name == 'eslint_d' then
			local bufnr = vim.uri_to_bufnr(result.uri)
			local ts_diagnostics = vim.diagnostic.get(bufnr, {
				severity = { min = vim.diagnostic.severity.ERROR },
			})

			-- Check if there are TS errors
			local has_ts_errors = false
			for _, diagnostic in ipairs(ts_diagnostics) do
				if
					diagnostic.source == 'ts_ls'
					or diagnostic.source == 'typescript'
					or diagnostic.source == 'tsserver'
				then
					has_ts_errors = true
					break
				end
			end

			-- If TS has errors, filter out ESLint diagnostics
			if has_ts_errors then
				result.diagnostics = vim.tbl_filter(function(d)
					-- Keep only non-ESLint diagnostics or warnings/info
					return d.severity ~= vim.diagnostic.severity.ERROR
				end, result.diagnostics or {})
			end
		end

		return original_handler(err, result, ctx, config)
	end

	-- Hover configuration
	vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, lsp.float)

	-- Signature help configuration
	vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, lsp.float)
end

return M
