local M = {}

M.setup = function(servers, options)
	local lspconfig = require('lspconfig')
	local icons = require('config.icons')

	require('mason').setup({
		ui = {
			icons = {
				package_installed = icons.server_installed,
				package_pending = icons.server_pending,
				package_uninstalled = icons.server_uninstalled,
			},
		},
	})

	require('mason-tool-installer').setup({
		ensure_installed = {
			'prettierd',
			'shfmt',
			'fixjson',
			'stylua',
			'selene',
			'shellcheck',
			'clang-format',
			'sqlfluff',
			'eslint_d',
			'js-debug-adapter',
		},
		auto_update = false,
		run_on_start = false,
	})

	pcall(function()
		require('neodev').setup({})
	end)

	require('mason-lspconfig').setup({
		ensure_installed = vim.tbl_keys(servers),
		automatic_installation = false,
		handlers = {
			function(server_name)
				if server_name == 'ts_ls' then
					return
				end

				if not servers[server_name] then
					return
				end

				-- Use vim.tbl_deep_extend with 'force' to preserve root_dir
				local server_config = servers[server_name] or {}
				local opts = vim.tbl_deep_extend('force', {}, options, server_config)

				lspconfig[server_name].setup(opts)
			end,

			['lua_ls'] = function()
				if servers['lua_ls'] then
					local opts = vim.tbl_deep_extend('force', {}, options, servers['lua_ls'])
					lspconfig.lua_ls.setup(opts)
				end
			end,

			['vtsls'] = function()
				if servers['vtsls'] then
					-- Important: merge in the correct order so root_dir isn't overwritten
					local opts = vim.tbl_deep_extend('force', {}, options, servers['vtsls'])
					lspconfig.vtsls.setup(opts)
				end
			end,
		},
	})
end

return M
