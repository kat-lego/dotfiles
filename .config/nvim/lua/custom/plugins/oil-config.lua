vim.api.nvim_create_autocmd('FileType', {
  pattern = 'oil',
  callback = function()
    vim.opt_local.colorcolumn = ''
  end,
})

return {
  'stevearc/oil.nvim',
  enabled = function()
    -- enable only if inside the /home/katlego/notes directory or its sub directories
    return string.sub(vim.loop.cwd(), 1, string.len '/home/katlego/notes') ~= '/home/katlego/notes'
  end,
  opts = {},
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup {
      use_default_keymaps = false,
      keymaps = {
        ['g?'] = 'actions.show_help',
        ['<CR>'] = 'actions.select',
        ['<C-enter>'] = 'actions.select_vsplit', -- this is used to navigate left
        ['<C-p>'] = 'actions.preview',
        ['<C-c>'] = 'actions.close',
        ['<C-r>'] = 'actions.refresh',
        ['-'] = 'actions.parent',
        ['_'] = 'actions.open_cwd',
        ['`'] = 'actions.cd',
        ['~'] = 'actions.tcd',
        ['gs'] = 'actions.change_sort',
        ['gx'] = 'actions.open_external',
        ['g.'] = 'actions.toggle_hidden',
      },
      view_options = {
        show_hidden = true,
      },
    }
    -- Map Oil to <leader>e
    local nnoremap = require('custom.user.keymap_utils').nnoremap
    nnoremap('<leader>e', function()
      require('oil').toggle_float()
    end, { desc = 'Toggle Oil' })
  end,
}
