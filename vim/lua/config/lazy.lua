local util = require('util')

if vim.env.TMUX then
	vim.cmd('packadd! vim-tmux-navigator')
end

util.augroup('init_lazy', {
	'Filetype markdown packadd! vim-markdown',
	'Filetype markdown packadd! vim-markdown-toc',
	'Filetype json,toml packadd! vim-package-info',
	'BufRead,BufNewFile requirements.txt,Pipfile packadd! vim-package-info',
	'Filetype applescript packadd! applescript.vim',
	'Filetype textile packadd! Textile-for-VIM',
	'Filetype java packadd! vim-classpath',
	'Filetype tex,latex packadd! vimtex',
})
