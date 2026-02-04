local M = {}

local servers = {
	angularls = {},
	graphql = {},
	vimls = {},
	buf_ls = {},
	ts_ls = {
		init_options = {
			hostInfo = 'neovim',
			maxTsServerMemory = 4096,
			preferences = {
				includeInlayParameterNameHints = 'none',
				includeCompletionsForImportStatements = false,
			},
		},
		settings = {
			typescript = {
				tsserver = {
					useSeparateSyntaxServer = false,
				},
			},
		},
	},
	cucumber_language_server = {},
	jsonls = {
		settings = {
			json = {
				schemas = require('schemastore').json.schemas(),
				validate = { enable = true },
			},
		},
	},
	yamlls = {
		settings = {
			yaml = {
				schemaStore = {
					enable = false, -- disable built in schema
				},
				schemas = require('schemastore').yaml.schemas(),
			},
		},
	},
	jdtls = {},
	lua_ls = {
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = 'LuaJIT',
					-- Setup your lua path
					path = vim.split(package.path, ';'),
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { 'vim', 'describe', 'it', 'before_each', 'after_each', 'packer_plugins', 'MiniTest' },
					-- disable = { "lowercase-global", "undefined-global", "unused-local", "unused-vararg", "trailing-space" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = {
						[vim.fn.expand('$VIMRUNTIME/lua')] = true,
						[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
					},
					-- library = vim.api.nvim_get_runtime_file("", true),
					maxPreload = 2000,
					preloadFileSize = 50000,
				},
				completion = { callSnippet = 'Replace' },
				telemetry = { enable = false },
				hint = {
					enable = false,
				},
			},
		},
	},
}

local function on_attach(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')

	if client.name == 'ts_ls' or client.name == 'tsserver' then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end

	require('config.lsp.keymaps').setup(client, bufnr)
	require('config.lsp.highlighting').setup(client)
	require('config.lsp.null-ls.formatters').setup(client, bufnr)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local opts = {
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
}

require('config.lsp.handlers').setup()

function M.setup()
	-- null-ls
	require('config.lsp.null-ls').setup(opts)

	-- Installer
	require('config.lsp.installer').setup(servers, opts)
end

return M
