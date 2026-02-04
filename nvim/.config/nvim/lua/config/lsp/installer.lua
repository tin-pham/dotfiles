local M = {}

M.setup = function(servers, options)
    local lspconfig = require('lspconfig')
    local icons = require('config.icons')

    -- 1. Setup Mason (Package Manager)
    require('mason').setup({
        ui = {
            icons = {
                package_installed = icons.server_installed,
                package_pending = icons.server_pending,
                package_uninstalled = icons.server_uninstalled,
            },
        },
    })

    -- 2. Setup Mason Tool Installer (Formatters/Linters)
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
            'eslintd',
            'js-debug-adapter',
            'hadolint',
            'yamllint',
        },
        auto_update = true,
        run_on_start = true,
    })

    -- 3. Setup Mason LSP Config (The Bridge)
    -- FIXED: We define 'handlers' inside setup() instead of calling setup_handlers() separately
    require('mason-lspconfig').setup({
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = false,
        handlers = {
            -- The default handler (runs for servers not explicitly listed below)
            function(server_name)
                local opts = vim.tbl_deep_extend('force', options, servers[server_name] or {})
                lspconfig[server_name].setup(opts)
            end,

            -- Dedicated handler for Lua
            ['lua_ls'] = function()
                -- Note: 'sumneko_lua' is deprecated, changed to 'lua_ls'
                local opts = vim.tbl_deep_extend('force', options, servers['lua_ls'] or servers['sumneko_lua'] or {})
                -- Note: neodev is deprecated in favor of lazydev.nvim, but keeping your config working:
                lspconfig.lua_ls.setup(require('neodev').setup({ lspconfig = opts }))
            end,

            -- Dedicated handler for TypeScript
            -- Note: 'tsserver' was recently renamed to 'ts_ls' in nvim-lspconfig
            ['ts_ls'] = function()
                local opts = vim.tbl_deep_extend('force', options, servers['ts_ls'] or servers['tsserver'] or {})
                
                -- Check if the deprecated 'typescript.nvim' plugin is actually loaded
                local status_ok, typescript = pcall(require, "typescript")
                if status_ok then
                    typescript.setup({
                        disable_commands = false,
                        debug = false,
                        server = opts,
                    })
                else
                    -- Fallback if the plugin is missing/archived
                    lspconfig.ts_ls.setup(opts)
                end
            end,
        }
    })
end

return M
