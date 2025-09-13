local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

function open_journal()
  local date = os.date("!%Y-%m-%d")
  local year = os.date("!%Y")
  local month = os.date("!%m")
  local journal_dir = os.getenv("HOME") .. "/orgfiles/journal/" .. year .. "/" .. month
  local journal_file = journal_dir .. "/" .. date .. ".org"

  -- Create directories if they don't exist
  os.execute("mkdir -p " .. journal_dir)

  -- Open the file
  vim.cmd("e " .. journal_file)
end

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
map('n', '<leader>dl', '<cmd>lua vim.diagnostic.setqflist()<CR><cmd>copen<CR>', opts)

-- Formatting
map('n', '<leader>f', '<cmd>Format<CR>', opts)

-- Orgmode
map('n', '<leader>oa', '<cmd>lua require("orgmode").action("agenda")<CR>', opts)
map('n', '<leader>oc', '<cmd>lua require("orgmode").action("capture")<CR>', opts)
map('n', '<leader>od', '<cmd>lua require("orgmode").action("deadline")<CR>', opts)
map('n', '<leader>oi', '<cmd>lua require("orgmode").action("heading_new")<CR>', opts)
map('n', '<leader>ot', ':e ~/orgfiles/todo.org<CR>', opts)
map('n', '<leader>oj', '<cmd>lua open_journal()<CR>', opts)
