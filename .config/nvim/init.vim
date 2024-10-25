" 横に行数を表示する
set number
" 改行時に前の行のインデントを継続する
set autoindent
" tabを半角スペースで挿入する
set expandtab
" 空白文字の可視化
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
" ターミナルのタイトルをセットする
set title
" タブ幅
set tabstop=4
" オートインデント時にインデントする文字数
set tabstop=2
set shiftwidth=2
set clipboard=unnamed

" カラースキームの設定: tender.vimが必要
" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif
" Theme
syntax enable
colorscheme tender
" set lighline theme inside lightline config
let g:lightline = { 'colorscheme': 'tender' }

" noremap
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>

" vim-jetpackを使った設定
packadd vim-jetpack
call jetpack#begin()
Jetpack 'tani/vim-jetpack', {'opt': 1}
" 下にかわいいステータスラインを表示する
Jetpack 'itchyny/lightline.vim',
" カラースキーム
Jetpack 'jacoborus/tender.vim',
call jetpack#end()
