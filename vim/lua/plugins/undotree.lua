vim.g.undotree_DiffAutoOpen = 0
vim.g.undotree_SetFocusWhenToggle = 1

require('util').keys.lmap('u', ':UndotreeToggle<cr>')
