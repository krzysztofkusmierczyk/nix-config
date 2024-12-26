-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number=true
vim.opt.relativenumber=true

vim.opt.clipboard = "unnamedplus"
vim.opt.shiftwidth = 4

vim.keymap.set("n", "<leader><leader>x","<cmd>source %<CR>")
vim.keymap.set("n", "<leader>x",":.lua<CR>")
vim.keymap.set("v", "<leader>x",":lua<CR>")
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

require("config.lazy")
