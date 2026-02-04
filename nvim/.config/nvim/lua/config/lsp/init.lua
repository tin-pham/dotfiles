local M = {}

local servers = {
  -- angularls = {},
  graphql = {},
  vimls = {},
  buf_ls = {},
  -- ts_ls = {
  -- 	init_options = {
  -- 		hostInfo = 'neovim',
  -- 		maxTsServerMemory = 4096,
  -- 	},
  -- 	settings = {
  -- 		typescript = {
  -- 			tsserver = {
  -- 				useSeparateSyntaxServer = true,
  -- 			},
  -- 		},
  -- 	},
  -- },
  vtsls = {
    filetypes = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
    },
    root_dir = function(fname)
      local cwd = vim.fn.getcwd()
      if vim.fn.filereadable(cwd .. '/package.json') == 1 then
        return cwd
      end

      -- Otherwise find the nearest package.json
      local util = require('lspconfig.util')
      return util.find_package_json_ancestor(fname)
    end,
    flags = {
      debounce_text_changes = 500,
      allow_incremental_sync = true,
    },
    settings = {
      typescript = {
        updateImportsOnFileMove = { enabled = 'never' },
        suggest = {
          completeFunctionCalls = false,
        },
        diagnostics = {
          ignoredCodes = {},
        },
        surveys = {
          enabled = false,
        },
        inlayHints = {
          parameterNames = { enabled = 'none' },
          parameterTypes = { enabled = false },
          variableTypes = { enabled = false },
          propertyDeclarationTypes = { enabled = false },
          functionLikeReturnTypes = { enabled = false },
          enumMemberValues = { enabled = false },
        },
        preferences = {
          includePackageJsonAutoImports = 'off',
        },
        tsserver = {
          maxTsServerMemory = 4096,
          experimental = {
            enableProjectDiagnostics = false,
          },
        },
      },
      javascript = {
        updateImportsOnFileMove = { enabled = 'never' },
      },
      vtsls = {
        autoUseWorkspaceTsdk = true,
        experimental = {
          completion = {
            enableServerSideFuzzyMatch = false,
          },
          maxInlayHintLength = 30,
          enableProjectWideIntellisense = false,
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
  require('config.lsp.null-ls.formatters').setup(client, bufnr)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local opts = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
    allow_incremental_sync = true, -- Add this if missing
  },
}

require('config.lsp.handlers').setup()

function M.setup()
  -- null-ls
  require('config.lsp.null-ls').setup(opts)

  -- Setup Mason (for the UI and tool management)
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

  -- null-ls
  require('config.lsp.null-ls').setup(opts)

  -- Setup neodev
  pcall(function()
    require('neodev').setup({})
  end)

  -- Load lspconfig
  local lspconfig = require('lspconfig')

  -- Setup all servers EXCEPT vtsls manually
  for server_name, server_config in pairs(servers) do
    if server_name ~= 'vtsls' then
      local config = vim.tbl_deep_extend('force', opts, server_config)
      lspconfig[server_name].setup(config)
    end
  end

  -- Setup vtsls with correct root
  lspconfig.vtsls.setup({
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
    flags = opts.flags,
    root_dir = function(fname)
      return vim.loop.cwd()
    end,
    settings = servers.vtsls.settings,
  })

  -- Block any vtsls with wrong root
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and client.name == 'vtsls' and client.config.root_dir ~= vim.loop.cwd() then
        vim.lsp.stop_client(client.id)
      end
    end,
  })
end

return M
