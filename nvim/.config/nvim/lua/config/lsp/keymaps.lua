local M = {}

local whichkey = require('which-key')

local keymap = vim.keymap.set

local function keymappings(client, bufnr)
	local opts = { noremap = true, silent = true }

	--keymap("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
	keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { buffer = bufnr })
	--keymap('n', 'L', '<cmd>Lspsaga peek_definition<CR>', { buffer = bufnr })
	keymap('n', 'E', '<cmd>Lspsaga show_line_diagnostics<CR>', { buffer = bufnr })

	keymap('n', 'T', '<cmd>Lspsaga open_floaterm<CR>', opts)
	keymap('t', 'T', [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], opts)

	keymap('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<cr>', opts)
	keymap('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<cr>', opts)
	-- keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	-- keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	keymap('n', 'gE', '<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>', opts)
	keymap('n', 'ge', '<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>', opts)

	-- Whichkey
	local keymap_l = {
		l = {
			name = 'Code Action',
			R = { '<cmd>Trouble lsp_references<cr>', 'Trouble References' },
			a = { '<cmd>Lspsaga code_action<CR>', 'Code Action' },
			f = { '<cmd>Lspsaga lsp_finder<CR>', 'Finder' },
			i = { '<cmd>LspInfo<CR>', 'Lsp Info' },
			n = { '<cmd>Lspsaga rename<CR>', 'Rename' },
			r = { '<cmd>Telescope lsp_references<CR>', 'References' },
			t = { '<cmd>TroubleToggle<CR>', 'Trouble' },
		},
	}

	-- Auto format on save
	if client.server_capabilities.document_formatting then
		keymap_l.l.f = { '<cmd>lua vim.lsp.buf.formatting()<CR>', 'Format Document' }
	end

	local keymap_g = {
		name = 'Goto',
		d = { '<Cmd>lua vim.lsp.buf.definition()<CR>', 'Definition' },
		D = { '<Cmd>lua vim.lsp.buf.declaration()<CR>', 'Declaration' },
		s = { '<cmd>lua vim.lsp.buf.signature_help()<CR>', 'Signature Help' },
		I = { '<cmd>lua vim.lsp.buf.implementation()<CR>', 'Goto Implementation' },
		t = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'Goto Type Definition' },
	}

	local o = { buffer = bufnr, prefix = '<leader>' }
	whichkey.register(keymap_l, o)
	o = { buffer = bufnr, prefix = 'g' }
	whichkey.register(keymap_g, o)
end

function M.setup(client, bufnr)
	keymappings(client, bufnr)
end

return M
