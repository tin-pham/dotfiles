local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr = { noremap = true, expr = true, silent = true }

-- Better escape using jk in insert and terminal mode
keymap('i', 'jk', '<ESC>', default_opts)
keymap('i', 'kj', '<ESC>', default_opts)
keymap('t', 'jk', '<C-\\><C-n>', default_opts)
keymap('t', 'kj', '<C-\\><C-n>', default_opts)

-- Move around split
keymap('n', '<C-h>', '<C-w>h', default_opts)
keymap('n', '<C-j>', '<C-w>j', default_opts)
keymap('n', '<C-k>', '<C-w>k', default_opts)
keymap('n', '<C-l>', '<C-w>l', default_opts)

-- Cancel search highlighting with ESC
keymap('n', '<ESC>', ':nohlsearch<Bar>:echo<CR>', default_opts)

-- Center search result
keymap('n', 'n', 'nzz', default_opts)
keymap('n', 'N', 'Nzz', default_opts)

-- Indent not leave the visual mode
keymap('v', '<', '<gv', default_opts)
keymap('v', '>', '>gv', default_opts)

-- Open terminal
-- keymap('n', '<C-\\>', ':terminal<cr>', default_opts)
-- keymap('i', '<C-\\>', ':terminal<cr>', default_opts)
-- keymap('v', '<C-\\>', ':terminal<cr>', default_opts)

-- Toggle tree
keymap('n', '<C-f>', ':NvimTreeToggle<CR>', default_opts);
