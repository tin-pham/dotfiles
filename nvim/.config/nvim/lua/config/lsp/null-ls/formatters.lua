local M = {}

-- local utils = require "utils"
-- local nls_utils = require "config.lsp.null-ls.utils" local nls_sources = require "null-ls.sources"

local method = require("null-ls").methods.FORMATTING
local nls_sources = require "null-ls.sources"

M.autoformat = true

function M.format()
	if M.autoformat then
		local view = vim.fn.winsaveview()
		vim.lsp.buf.format {
			async = true,
			filter = function(client)
				return 
          client.name ~= "tsserver"
						and client.name ~= "jsonls"
						and client.name ~= "html"
						and client.name ~= "sumneko_lua"
						and client.name ~= "jdtls"
				-- and client.name ~= "kotlin_language_server"
			end,
		}
		vim.fn.winrestview(view)
	end
end

function M.setup(client, buf)
	local filetype = vim.api.nvim_buf_get_option(buf, 'filetype')

	local enable = false
	if M.has_formatter(filetype) then
		enable = client.name == "null-ls"
	else
		enable = not (client.name == "null-ls")
	end

	client.server_capabilities.document_formatting = enable
	client.server_capabilities.document_range_formatting = enable
	if client.server_capabilities.document_formatting then vim.cmd [[
      augroup LspFormat
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua require('config.lsp.null-ls.formatters').format()
      augroup END
    ]]
	end
end

function M.has_formatter(filetype)
	local available = nls_sources.get_available(filetype, method)
	return #available > 0
end

return M
