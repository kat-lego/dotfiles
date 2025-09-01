-- See `:help mapleader`
-- Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- [[ Setting options ]]
require 'options'

-- [[Setting Keymaps ]]
require 'keymaps'

-- [[Setting Auto Commands ]]
require 'autocommands'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Install Lazy plugins ]]
require 'lazy-plugins'
