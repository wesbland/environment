function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin('~/.config/nvim/plugged')
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'sickill/vim-monokai'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'wesbland/cscope.nvim'
Plug 'neomake/neomake'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
call plug#end()

filetype plugin indent on

colorscheme monokai

" Turn on airline
set laststatus=2
let g:airline_powerline_fonts=1 " Turn on powerline fonts for airline
let g:airline#extensions#whitespace#enabled=0 " Turn of the mixed indent section
let g:airline#extensions#whitespace#trailing_format='t[%s]' " Shorten the mixed indent section
let g:airline#extensions#whitespace#mixed_indent_format='m[%s]' " Shorten the mixed indent section
let g:airline_section_y='' " Turn off the section with the encoding

set exrc                " Allow directory specific .nvimrc files
set nu                  " Line numbers on
set showmatch 			" Show matching brackets/parens
set incsearch			" Find as you type search
set hlsearch			" Highlight search terms
set ignorecase			" Case insensitive search
set smartcase			" Case sensitive when uc present
set whichwrap=b,s,h,l,<,>,[,]	" Set characters to wrap to
set foldmethod=syntax		" Use syntax defined folding
autocmd BufWinEnter * silent! :%foldopen! " Open all folds by default
let mysyntaxfile="$HOME/.vim/mysyntax/mpich3.1.vim" " Turn on syntax highlighting for MPI
set showtabline=2

set nowrap			" Turn off line wrapping on long lines
set autoindent			" Indent at the same level as previous lines
set shiftwidth=4		" Use indents of 4 spaces
set expandtab			" Use spaces, not tabs
set tabstop=4			" Indent every 4 columns
set smarttab
set softtabstop=4		" Let backspace delete indents
set pastetoggle=<F10>		" Same indentation on pastes
set comments=s1:/*,mb:*,elx:*/  " Auto format comment blocks
set list listchars=tab:\>>      " Show the indent characters so I don't screw up existing formatting

" Highlight trailing whitespace in red
" Have this highlighting not appear while in insert mode
" Have the highlighting of whitespace apply when new buffers are opened
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Make ; work like : for commands
nnoremap ; :

" Easier moving in tabs and windows
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_

" Clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

" Shortcuts for saving and closing
map W  :wq<CR>
map Q  :q<CR>

" Update and reset the cscope tags
nmap <leader>c :update_cscope<CR>
			\:cs reset<CR>
cs add $CSCOPE_DB

" Turn on TagBar with \l
nnoremap <leader>l :TagbarToggle<CR><Paste>

" Fuzzy Finder stuff
" This is the default extra key bindings
let g:fzf_action = {
			\ 'ctrl-t': 'tab split',
			\ 'ctrl-x': 'split',
			\ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" Path to store the cscope files
let g:cscope_dir = '~/.nvim-cscope'
" Map default keys on startup
let g:cscope_map_keys = 1
" Update the cscope files on startup of cscope
let g:cscope_update_on_start = 1
" Set the default config file name
let g:cscope_config = '.cscope.cfg'
autocmd VimEnter * CScopeStart

"let g:neomake_cpp_gcc_maker = {
"    \ 'exe': '/opt/rh/devtoolset-4/root/usr/bin/gcc',
"    \ 'args': ['-Wall',
"             \ '-c',
"             \ '-DHVAE_CONFIG_H',
"             \ '-DMPIDI_POSIX_USE_LOCK_FREE_QUEUES',
"             \ '-DSHM_DIRECT=__shm_direct_posix__',
"             \ '-DNETMOD_DIRECT=__netmod_direct_ofi__',
"             \ '-DNETMOD_DISABLE_INLINES',
"             \ '-D_REENTRANT',
"             \ '-fPIC',
"             \ '-DPIC',
"             \ '-I.',
"             \ '-I./include',
"             \ '-I./src/include',
"             \ '-I./src/mpi/datatype',
"             \ '-I./src/mpi/spawn',
"             \ '-I./src/mpi/romio/include',
"             \ '-I./src/mpid/include',
"             \ '-I./src/mpid/ch4/include',
"             \ '-I./src/mpid/ch4/netmod/include',
"             \ '-I./src/mpid/ch4/netmod/ofi',
"             \ '-I./src/mpl/include/',
"             \ '-I./src/openpa/src',
"             \ '-I./src/mpid/common/datatype/',
"             \ '-I./src/mpid/common/thread/',
"             \ '-I./src/mpid/common/sched/',
"             \ '-I./src/mpid/common/shm/',
"             \ '-I./src/mpid/common/timers/',
"             \ '-I./src/mpid/ch4/shm/include/',
"             \ '-I./src/mpid/ch4/src/',
"             \ '-I./src/mpid/ch4/generic/',
"             \ '-I./src/util/nodemap/',
"             \ '-I./src/util/procmap/',
"             \ '-I./src/util/logging/common/',
"             \ '-I./src/util/mem/',
"             \ '-I./src/util/wrappers/',
"             \ '-I./src/binding/cxx/',
"             \ '-I./src/binding/fortran/',
"             \ '-I./src/binding/fortran/use_mpi',
"             \ '-I./src/pmi/simple/',
"             \ '-include','netmod_direct.h',
"        \ ],
"    \ }

let g:neomake_open_list = 2
autocmd! BufWritePost * Neomake
"let g:neomake_verbose=3
"let g:neomake_logfile='/tmp/error.log'
