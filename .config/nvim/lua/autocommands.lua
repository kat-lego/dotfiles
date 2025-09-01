-- abbreviations
vim.cmd 'iabbrev idate <C-R>=strftime("%b %d %Y")<CR>'
vim.cmd 'iabbrev itime <C-R>=strftime("%H:%M")<CR>'
vim.cmd 'iabbrev idt <C-R>=strftime("%b %d %Y %H:%M")<CR>'

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- set autocommand to set filetype for biceps
vim.cmd [[ autocmd BufNewFile,BufRead *.bicep set filetype=bicep ]]
