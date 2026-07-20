vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.clipboard = 'unnamedplus'

vim.o.number = true

vim.o.signcolumn = 'yes'

-- Use spaces instead of tabs and set width to 2
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.o.updatetime = 300

vim.o.termguicolors = true

vim.o.mouse = 'a'

vim.diagnostic.enable = true
vim.diagnostic.config({
  virtual_lines = true,
})
