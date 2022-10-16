local M = {}

local servers = {
	sumneko_lua = {
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
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = {
						[vim.fn.expand "$VIMRUNTIME/lua"] = true,
						[vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
					},
				},
			}
		}
	},
	vimls = {},
	tsserver = {},
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    },
  },
  sqls = {},
	jdtls = {},
  prismals = {},
   yamlls = {
    schemastore = {
      enable = true,
    },
    settings = {
      yaml = {
        hover = true,
        completion = true,
        validate = true,
        schemas = require("schemastore").json.schemas(),
      },
    },
  },
}

local function on_attach(client, bufnr)
	-- Enable completion triggered by <C-X><C-O>
	-- See `:help omnifunc` and `:help ins-completion` for more information.
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Use LSP as the handler for formatexpr.
	-- See `:help formatexpr` for more information.
	vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')


	-- Configure key mappings
	require('config.lsp.keymaps').setup(client, bufnr)

	-- Configure highlighting
	require('config.lsp.highlighting').setup(client)


	-- Configure formatting
	require("config.lsp.null-ls.formatters").setup(client, bufnr)

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
