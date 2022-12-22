return {
  'nvim-treesitter/nvim-treesitter',

  dependencies = {
    'nvim-lua/plenary.nvim',
    -- provide TSHighlightCapturesUnderCursor command
    'nvim-treesitter/playground',
    -- set proper commentstring for embedded languages
    'JoosepAlviste/nvim-ts-context-commentstring',
  },

  -- build = ':TSUpdate',

  config = function()
    local configs = require('nvim-treesitter.configs')

    -- local legacy_filetypes = vim.list_extend({
    --   'html',
    --   'css',
    --   'scss',
    --   'lua',
    --   'java',
    --   'go',
    --   'json',
    --   'python',
    -- }, require('user.util').ts_types)
    local legacy_filetypes = {}

    local config = {
      highlight = {
        enable = true,
        -- this option prevents treesitter highlighting from breaking indenting
        -- see https://github.com/nvim-treesitter/nvim-treesitter/discussions/1271#discussioncomment-795299
        -- this should be set to a list of filetypes, but that doesn't work
        -- https://github.com/nvim-treesitter/nvim-treesitter#modules
        -- additional_vim_regex_highlighting = true
        additional_vim_regex_highlighting = legacy_filetypes,
      },
      indent = {
        enable = true,
        -- indenting is currently broken for several languages, particularly for doc
        -- comments
        disable = legacy_filetypes,
      },
      matchup = {
        enable = true,
      },
      context_commentstring = {
        enable = true,
      },
    }

    config.ensure_installed = {
      'bash',
      'c',
      'comment',
      'cpp',
      'css',
      'dockerfile',
      'go',
      'html',
      'java',
      'javascript',
      'jsdoc',
      'json',
      'json5',
      'jsonc',
      'lua',
      'prisma',
      'python',
      'rust',
      'scss',
      'svelte',
      'swift',
      'tsx',
      'typescript',
      'yaml',
    }

    configs.setup(config)
  end,
}
