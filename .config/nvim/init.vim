let mapleader=","
set noerrorbells visualbell t_vb=
set wildmenu
set lazyredraw
set showmatch
set autowriteall
set backspace=2   
set nobackup
set nowritebackup
set noswapfile    
set history=50
set ruler         
set showcmd       
set laststatus=2
set noshowmode
set timeoutlen=1000
set ttimeoutlen=0
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set scrolloff=3

"filetype plugin indent on

syntax on

let g:python_host_prog = '/Users/jimboy/.pyenv/versions/2.7.8/bin/python2'
let g:python3_host_prog = '/Users/jimboy/.pyenv/versions/3.7.0/bin/python3'

nmap <leader>ev :tabedit ~/.config/nvim/init.vim<cr>

"--------------------Search-------------------"
set incsearch
set hlsearch
nnoremap <leader><space> :nohlsearch<CR>

"-------------Split-Management----------------"
set splitbelow
set splitright

if has("autocmd")
  filetype plugin indent on
endif

"------------------FZF-----------------------"
let $FZF_DEFAULT_COMMAND= 'ag -g ""'
let g:fzf_history_dir = '~/.local/share/fzf-history'
function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

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

autocmd! User FzfStatusLine call <SID>fzf_statusline()

nmap <C-p> :FZF<cr>

let g:jsx_ext_required = 0

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:deoplete#enable_at_startup = 1

let g:EditorConfig_core_mode = 'external_command'

"------------------Emmet----------------------"
let g:user_emmet_install_global = 0
let g:user_emmet_leader_key='<tab>'
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}
autocmd FileType html,css,javascript.jsx EmmetInstall

"------------------PHP-CS-------------------------"
let g:php_cs_fixer_rules = "@PSR2,no_unused_imports" 
nnoremap <silent><leader>pf :call PhpCsFixerFixFile()<CR>

" -- Smart indent when entering insert mode with i on empty lines --------------
function! IndentWithI()
  if len(getline('.')) == 0
    return "\"_ddO"
  else
    return "i"
  endif
endfunction
nnoremap <expr> i IndentWithI()

let g:flow#autoclose = 1

let g:prettier#exec_cmd_async = 1
let g:prettier#autoformat = 1

" vim plug
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-vinegar'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'stephpy/vim-php-cs-fixer'
Plug 'wakatime/vim-wakatime'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'SirVer/ultisnips'
Plug 'StanAngeloff/php.vim'
Plug 'wayanjimmy/vim-snippets'
Plug 'editorconfig/editorconfig-vim'
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mattn/emmet-vim'
Plug 'joshdick/onedark.vim'
Plug 'nelsyeung/twig.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'prettier/vim-prettier', { 
	\ 'do': 'yarn install', 
	\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] } 
"Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
call plug#end()

colorscheme onedark
