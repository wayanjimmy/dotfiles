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
set nocompatible
set encoding=utf-8
set showtabline=0

"filetype plugin indent on

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
set rtp+=/usr/local/opt/fzf
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
nmap<leader>ff :Buffers<CR>
nmap<leader>e :terminal<CR>

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

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

let g:EditorConfig_exec_path = '/usr/local/bin/editorconfig'

" -------------------------------------------------------------------------------------------------
" coc.nvim default settings
" -------------------------------------------------------------------------------------------------

" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

let g:CtrlSpaceDefaultMappingKey = "<C-space> "
let g:CtrlSpaceFileEngine = '~/.config/nvim/plugged/vim-ctrlspace' . '/bin/file_engine_darwin_amd64'
if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif

" vim plug
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhinz/vim-mix-format'
Plug 'fatih/vim-go'
Plug 'editorconfig/editorconfig-vim'
Plug 'jxnblk/vim-mdx-js'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'junegunn/goyo.vim'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'tpope/vim-obsession'
Plug 'KeitaNakamura/neodark.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'rakr/vim-one'
call plug#end()

"""" enable 24bit true color
"set termguicolors
set background=dark
colorscheme nord
