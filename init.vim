" bootstrap vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" install missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sbdchd/neoformat'
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'preservim/nerdcommenter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'tag': 'legacy' }
endif
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
call plug#end()

colorscheme gruvbox

set number

let mapleader=","

nnoremap <leader>f :Neoformat<CR>

" nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
" nnoremap <C-f> :NERDTreeFind<CR>

nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>

" set
autocmd TermEnter term://*toggleterm#*
      \ tnoremap <silent><c-l> <Cmd>exe v:count1 . "ToggleTerm"<CR>

" By applying the mappings this way you can pass a count to your
" mapping to open a specific window.
" For example: 2<C-t> will open terminal 2
nnoremap <silent><c-l> <Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent><c-l> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>

inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

lua << END
require("toggleterm").setup{
direction='float'
}
END

