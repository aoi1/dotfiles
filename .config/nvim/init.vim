"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " dein.toml, dein_layz.tomlファイルのディレクトリをセット
  let s:toml_dir = expand('~/.config/nvim')

  " 起動時に読み込むプラグイン群
  call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})

  " 遅延読み込みしたいプラグイン群
  call dein#load_toml(s:toml_dir . '/dein_lazy.toml', {'lazy': 1})

  " You can specify revision/branch/tag.
  call dein#add('Shougo/deol.nvim', { 'rev': 'a1b5108fd' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" デフォルトでNERDTree表示
" autocmd VimEnter * execute 'NERDTree'

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"End dein Scripts-------------------------

" tender
if (has("termguicolors"))
 set termguicolors
endif

syntax enable
colorscheme tender

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

" markdown viewer
au BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd = 'open -a Firefox'

" vim-syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" lightline
set noshowmode
let g:lightline = {
  \'colorscheme':'wombat',
  \'active': {
  \  'left': [
  \    ['mode', 'paste'],
  \    ['fugitive', 'filename'],
  \    ['ale'],
  \  ]
  \},
  \'component_function': {
  \  'fugitive': 'MyFugitive',
  \  'ale': 'MyALEStatus'
  \}
\ }

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head') && strlen(fugitive#head())
      return ' ' . fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyALEStatus()
  return ALEGetStatusLine()
endfunction

let g:ale_statusline_format = ['💀 %d', '⚠ %d', '😉  ok']
