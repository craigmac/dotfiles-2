-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/jason/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/jason/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/jason/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/jason/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/jason/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["FixCursorHold.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/FixCursorHold.nvim"
  },
  ["Navigator.nvim"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.Navigator\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/Navigator.nvim"
  },
  ["Textile-for-VIM"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/Textile-for-VIM"
  },
  ["applescript.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/applescript.vim"
  },
  ["denops.vim"] = {
    loaded = true,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/start/denops.vim"
  },
  ["diffview.nvim"] = {
    commands = { "DiffviewOpen" },
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rdiffview\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/diffview.nvim"
  },
  ["editorconfig-vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/editorconfig-vim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    load_after = {
      ["plenary.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nd\0\0\2\0\5\0\t6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0+\1\1\0=\1\4\0K\0\1\0\29indent_blankline_enabled\b│\26indent_blankline_char\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim"
  },
  ["jsonc.vim"] = {
    loaded = true,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/start/jsonc.vim"
  },
  ["lsp_signature.nvim"] = {
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/lsp_signature.nvim"
  },
  ["lualine-lsp-progress"] = {
    config = { "\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20plugins.lualine\frequire\0" },
    load_after = {
      ["lualine.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/lualine-lsp-progress"
  },
  ["lualine.nvim"] = {
    after = { "lualine-lsp-progress" },
    load_after = {
      ["nvim-web-devicons"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/lualine.nvim"
  },
  neogit = {
    commands = { "Neogit" },
    config = { "\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19plugins.neogit\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/neogit"
  },
  ["null-ls.nvim"] = {
    after = { "nvim-lsp-ts-utils" },
    config = { "\27LJ\2\nc\0\0\3\0\4\0\n6\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0016\0\0\0'\2\3\0B\0\2\1K\0\1\0\28plugins.nvim-lspinstall\blsp\20plugins.null-ls\frequire\0" },
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/null-ls.nvim"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    after_files = { "/Users/jason/.local/share/nvim/site/pack/packer/opt/nvim-compe/after/plugin/compe.vim" },
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.nvim-compe\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/nvim-compe"
  },
  ["nvim-lsp-ts-utils"] = {
    load_after = {
      ["null-ls.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/nvim-lsp-ts-utils"
  },
  ["nvim-lspconfig"] = {
    after = { "lsp_signature.nvim", "null-ls.nvim", "trouble.nvim" },
    load_after = {
      ["nvim-lspinstall"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    after = { "nvim-lspconfig" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/nvim-lspinstall"
  },
  ["nvim-tree.lua"] = {
    commands = { "NvimTreeToggle" },
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.nvim-tree\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugins.nvim-treesitter\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    after = { "lualine.nvim" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    after = { "popup.nvim", "gitsigns.nvim" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/plenary.nvim"
  },
  ["popup.nvim"] = {
    load_after = {
      ["plenary.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/popup.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    commands = { "Telescope" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/telescope-fzy-native.nvim"
  },
  ["telescope-symbols.nvim"] = {
    commands = { "Telescope" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/telescope-symbols.nvim"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.telescope\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/telescope.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20plugins.trouble\frequire\0" },
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/trouble.nvim"
  },
  undotree = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21plugins.undotree\frequire\0" },
    loaded = true,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/start/undotree"
  },
  ["vim-bbye"] = {
    commands = { "Bdelete" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/vim-bbye"
  },
  ["vim-classpath"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/vim-classpath"
  },
  ["vim-commentary"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/vim-commentary"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-illuminate"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.illuminate\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/vim-illuminate"
  },
  ["vim-markdown"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/vim-markdown"
  },
  ["vim-markdown-toc"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/vim-markdown-toc"
  },
  ["vim-matchup"] = {
    after_files = { "/Users/jason/.local/share/nvim/site/pack/packer/opt/vim-matchup/after/plugin/matchit.vim" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/vim-matchup"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-startify"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21plugins.startify\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/vim-startify"
  },
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/vim-startuptime"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  vimtex = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/jason/.local/share/nvim/site/pack/packer/opt/vimtex"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: undotree
time([[Config for undotree]], true)
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21plugins.undotree\frequire\0", "config", "undotree")
time([[Config for undotree]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
if vim.fn.exists(":NvimTreeToggle") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file NvimTreeToggle lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":Neogit") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file Neogit lua require("packer.load")({'neogit'}, { cmd = "Neogit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":Telescope") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope-fzy-native.nvim', 'telescope-symbols.nvim', 'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":DiffviewOpen") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file DiffviewOpen lua require("packer.load")({'diffview.nvim'}, { cmd = "DiffviewOpen", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":StartupTime") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":Bdelete") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file Bdelete lua require("packer.load")({'vim-bbye'}, { cmd = "Bdelete", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType java ++once lua require("packer.load")({'vim-classpath'}, { ft = "java" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-markdown', 'vim-markdown-toc'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType tex ++once lua require("packer.load")({'vimtex'}, { ft = "tex" }, _G.packer_plugins)]]
vim.cmd [[au FileType applescript ++once lua require("packer.load")({'applescript.vim'}, { ft = "applescript" }, _G.packer_plugins)]]
vim.cmd [[au FileType textile ++once lua require("packer.load")({'Textile-for-VIM'}, { ft = "textile" }, _G.packer_plugins)]]
vim.cmd [[au FileType latex ++once lua require("packer.load")({'vimtex'}, { ft = "latex" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-compe'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au CursorMoved * ++once lua require("packer.load")({'vim-matchup'}, { event = "CursorMoved *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'nvim-treesitter', 'vim-commentary', 'vim-illuminate', 'nvim-colorizer.lua', 'indent-blankline.nvim'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'FixCursorHold.nvim', 'Navigator.nvim', 'editorconfig-vim', 'vim-startify', 'nvim-web-devicons', 'plenary.nvim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'nvim-lspinstall'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/jason/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], true)
vim.cmd [[source /Users/jason/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]]
time([[Sourcing ftdetect script at: /Users/jason/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], false)
time([[Sourcing ftdetect script at: /Users/jason/.local/share/nvim/site/pack/packer/opt/vim-markdown-toc/ftdetect/markdown.vim]], true)
vim.cmd [[source /Users/jason/.local/share/nvim/site/pack/packer/opt/vim-markdown-toc/ftdetect/markdown.vim]]
time([[Sourcing ftdetect script at: /Users/jason/.local/share/nvim/site/pack/packer/opt/vim-markdown-toc/ftdetect/markdown.vim]], false)
time([[Sourcing ftdetect script at: /Users/jason/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]], true)
vim.cmd [[source /Users/jason/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]]
time([[Sourcing ftdetect script at: /Users/jason/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
