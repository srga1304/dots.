-- ~/.config/nvim/init.lua

vim.o.termguicolors = true

vim.o.mouse = ""

vim.cmd.colorscheme("retrobox") -- базовая цветовая схема из Vim
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

vim.cmd("syntax on") -- включить подсветку синтаксиса

vim.api.nvim_set_option("clipboard", "unnamed")

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.cursorline = true
vim.wo.cursorcolumn = false

-- Настраиваем CursorLine для подчеркивания
vim.api.nvim_set_hl(0, 'CursorLine', { bg = 'NONE', underline = true, sp = '#d8d8d8' })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#d8d8d8', bg = 'NONE' })

require("config.keymaps")
require("config.lazy")

-- Для Lackluster:
-- vim.cmd("colorscheme lackluster")
-- Или для Everforest:
-- vim.cmd("colorscheme everforest")
