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

let g:python_host_prog = '/Users/jimboy/.pyenv/versions/2.7.17/bin/python2'
let g:python3_host_prog = '/Users/jimboy/.pyenv/versions/3.7.5/bin/python3'

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

"let g:EditorConfig_core_mode = 'external_command'

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

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

command! -nargs=0 Prettier :CocCommand prettier.formatFile

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

let g:EditorConfig_exec_path = '/usr/local/bin/editorconfig'

" vim plug
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-vinegar'
Plug 'lepture/vim-jinja'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'stephpy/vim-php-cs-fixer'
Plug 'wakatime/vim-wakatime'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'SirVer/ultisnips'
Plug 'StanAngeloff/php.vim'
Plug 'wayanjimmy/vim-snippets'
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'joshdick/onedark.vim'
Plug 'nelsyeung/twig.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhinz/vim-mix-format'
Plug 'fatih/vim-go'
Plug 'editorconfig/editorconfig-vim'
Plug 'jxnblk/vim-mdx-js'
call plug#end()

colorscheme onedark
