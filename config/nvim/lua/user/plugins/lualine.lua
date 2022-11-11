local M = {}

M.config = function()
  local theme = require('user.util.theme')
  local req = require('user.req')

  -- make statusline transparent so we don't get a flash before lualine renders
  theme.hi('StatusLine', { bg = '' })
  theme.hi('StatusLineNC', { bg = '' })

  local config = {
    options = {
      theme = 'wezterm',
      section_separators = { left = ' ', right = ' ' },
      component_separators = { left = '│', right = '│' },
      globalstatus = true,
    },
    sections = {
      lualine_b = {
        -- { 'branch', icon = '', padding = { left = 0, right = 1 } },
        {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          padding = { left = 0, right = 1 },
        },
        { 'diff', padding = { left = 0, right = 1 } },
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {
        { 'progress', padding = { left = 1, right = 0 } },
      },
    },
    winbar = {
      lualine_c = {
        { 'filetype', icon_only = 1 },
        { 'filename', path = 1, padding = { left = 1, right = 1 } },
      },
      lualine_x = {
        {
          'language_servers',
          separator = '',
          padding = { left = 1, right = 1 },
        },
        {
          'lsp_progress',
          display_components = { 'spinner' },
          spinner_symbols = { '⠖', '⠲', '⠴', '⠦' },
          timer = { spinner = 250 },
          padding = { left = 1, right = 1 },
        },
      },
    },
    extensions = { 'nvim-tree', 'quickfix' },
  }

  config.inactive_winbar = config.winbar

  local navic = req('nvim-navic')
  if navic then
    table.insert(
      config.sections.lualine_c,
      { navic.get_location, cond = navic.is_available }
    )
  end

  local outline = req('symbols-outline')
  if outline then
    table.insert(config.extensions, 'symbols_outline')
  end

  require('lualine').setup(config)
end

return M
