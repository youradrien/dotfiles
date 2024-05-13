syntax on
filetype on

let g:polyglot_disabled = ['markdown']


call plug#begin()

Plug 'morhetz/gruvbox'
Plug 'Yggdroot/indentLine'
Plug 'psliwka/vim-smoothie'
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

set guicursor=

set smartindent
set scrolloff=12
set updatetime=5
set number

:set tabstop=4
:set shiftwidth=4

let g:gruvbox_contrast_dark = 'hard'
set background=dark
colorscheme gruvbox

set laststatus=2
"let g:lightline = {
"      \ 'colorscheme': 'gruvbox',
"      \ }

set nobackup
set nowritebackup

" <tab> to trigger completion
"function! CheckBackspace() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

"inoremap <silent><expr> <Tab>
"      \ coc#pum#visible() ? coc#pum#next(1) :
"      \ CheckBackspace() ? "\<Tab>" :
"      \ coc#refresh()

"let g:coc_global_extensions = ['coc-json', 'coc-clangd',  'coc-sql', 'coc-graphql', 'coc-html', 'coc-highlight']
