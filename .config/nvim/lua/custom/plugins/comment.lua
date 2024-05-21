return {
  'numToStr/Comment.nvim',
  opts = {},
  config = function()
    require('Comment').setup()
    local ft = require 'Comment.ft'

    ft.set('bicep', { '//%s', '/*%s*/' })
  end,
}
