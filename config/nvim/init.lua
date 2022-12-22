-- disable shadafile while sourcing config
-- https://www.reddit.com/r/neovim/comments/opipij/guide_tips_and_tricks_to_reduce_startup_and/
vim.opt.shadafile = 'NONE'

pcall(require, 'impatient')

require('user.config.options')
require('user.config.lazy')
require('user.config.keymaps')
require('user.config.autocommands')
require('user.config.linenr')

vim.opt.shadafile = ''
