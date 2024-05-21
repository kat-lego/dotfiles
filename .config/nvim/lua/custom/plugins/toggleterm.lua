return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {},
  config = function()
    require('toggleterm').setup {
      open_mapping = [[<c-t>]],
      insert_mappings = false, -- close the terminal when you hit escape
      hide_numbers = true, -- hide the number column in toggleterm buffers
      direction = 'float', -- open the terminal in a floating window
      float_opts = {
        border = 'curved', -- rounded borders
      },
    }
  end,
}
