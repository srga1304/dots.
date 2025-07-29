local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Set leader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- File browser
map('n', '<leader>pv', ':Ex<CR>', opts)
map('n', '<leader>ff', ':Files<CR>', opts)

-- LSP
map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
map('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
map('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

-- Formatting
map('n', '<leader>f', '<cmd>Format<CR>', opts)
