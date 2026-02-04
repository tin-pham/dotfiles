local M = {}

local whichkey = require('which-key')
local keymap = vim.keymap.set

local function keymappings(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- 1. Native Vim keymaps (Keep these as they are)
	keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
	keymap('n', 'E', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
	keymap('n', 'T', '<cmd>Lspsaga open_floaterm<CR>', opts)
	keymap('t', 'T', [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], opts)
	keymap('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<cr>', opts)
	keymap('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<cr>', opts)
	keymap('n', 'gE', '<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>', opts)
	keymap('n', 'ge', '<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>', opts)

	-- 2. Define Which-Key Mappings (v3 Spec)
	local mappings = {
		-- "Goto" Group (g)
		{ "g", group = "Goto", buffer = bufnr },
		{ "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", desc = "Definition", buffer = bufnr },
		{ "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Declaration", buffer = bufnr },
		{ "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "Signature Help", buffer = bufnr },
		{ "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Goto Implementation", buffer = bufnr },
		{ "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", desc = "Goto Type Definition", buffer = bufnr },

		-- "Code Action" Group (<leader>l)
		{ "<leader>l", group = "Code Action", buffer = bufnr },
		{ "<leader>lR", "<cmd>Trouble lsp_references<cr>", desc = "Trouble References", buffer = bufnr },
		{ "<leader>la", "<cmd>Lspsaga code_action<CR>", desc = "Code Action", buffer = bufnr },
		{ "<leader>li", "<cmd>LspInfo<CR>", desc = "Lsp Info", buffer = bufnr },
		{ "<leader>ln", "<cmd>Lspsaga rename<CR>", desc = "Rename", buffer = bufnr },
		{ "<leader>lr", "<cmd>Lspsaga incoming_calls<CR>", desc = "References", buffer = bufnr },
		{ "<leader>lt", "<cmd>TroubleToggle<CR>", desc = "Trouble", buffer = bufnr },
	}

	-- 3. Handle Conditional Mapping (Format vs Finder)
	-- Default behavior: <leader>lf opens Finder
	local f_mapping = { "<leader>lf", "<cmd>Lspsaga lsp_finder<CR>", desc = "Finder", buffer = bufnr }

	-- If server supports formatting, overwrite <leader>lf to Format
	if client.server_capabilities.document_formatting then
		f_mapping = { "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", desc = "Format Document", buffer = bufnr }
	end

	-- Add the decided 'f' mapping to the list
	table.insert(mappings, f_mapping)

	-- 4. Register
	whichkey.add(mappings)
end

function M.setup(client, bufnr)
	keymappings(client, bufnr)
end

return M
