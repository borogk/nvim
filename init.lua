require("config.lazy")

vim.o.termguicolors = true
vim.o.number = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.cmd.colorscheme('retrobox')

vim.keymap.set('n', '|', '<cmd>Neotree<cr>')
vim.keymap.set('n', '<C-t>', '<cmd>Telescope<cr>')
vim.keymap.set('n', '<C-n>', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<C-g>', '<cmd>Telescope live_grep<cr>')

