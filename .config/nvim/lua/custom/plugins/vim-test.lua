return {
  'vim-test/vim-test',
  lazy = false,
  dependencies = {
    'preservim/vimux',
  },
  config = function()
    vim.g['test#csharp#runner'] = 'dotnettest'
    vim.g['test#strategy'] = 'vimux'
    vim.keymap.set('n', '<leader>tn', '<cmd>TestNearest<cr>', { noremap = true, desc = 'Run nearest test' })
    vim.keymap.set('n', '<leader>tf', '<cmd>TestFile<cr>', { noremap = true, desc = 'Run current file' })
    vim.keymap.set('n', '<leader>ts', '<cmd>TestSuite<cr>', { noremap = true, desc = 'Run test suite' })
    vim.keymap.set('n', '<leader>tl', '<cmd>TestLast<cr>', { noremap = true, desc = 'Run last test' })
    vim.keymap.set('n', '<leader>tv', '<cmd>TestVisit<cr>', { noremap = true, desc = 'Visit test file' })
  end,
}
