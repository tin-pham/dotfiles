local M = {}

function M.setup(servers, options)
	local lspconfig = require 'lspconfig'
	local icons = require 'config.icons'

	require('mason').setup {
		ui = {
			icons = {
				package_installed = icons.server_installed,
				package_pending = icons.server_pending,
				package_uninstalled = icons.server_uninstalled,
			},
		},
	}

	require('mason-tool-installer').setup {
		ensure_installed = { 'prettierd', 'shfmt', 'fixjson', 'stylua', 'selene', 'shellcheck', 'clang-format', 'sqlfluff', 'eslint_d' },
		auto_update = true,
		run_on_start = true,
	}

	require('mason-lspconfig').setup {
		ensure_installed = vim.tbl_keys(servers),
		automatic_installation = false,
	}
	-- Package installation folder
	--local install_root_dir = vim.fn.stdpath 'data' .. '/mason'

	require('mason-lspconfig').setup_handlers {
		function(server_name)
			local opts = vim.tbl_deep_extend('force', options, servers[server_name] or {})
			lspconfig[server_name].setup(opts)
		end,

		["sumneko_lua"] = function()
			local opts = vim.tbl_deep_extend("force", options, servers["sumneko_lua"] or {})
			lspconfig.sumneko_lua.setup(require("neodev").setup { lspconfig = opts })
		end,
    ["tsserver"] = function ()
      local opts = vim.tbl_deep_extend("force", options, servers['tsserver'] or {}) 
      require('typescript').setup {
        disable_commands = false,
        debug = false,
        server = opts
      }
    end
	}
end

return M
