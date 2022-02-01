
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

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"End dein Scripts-------------------------

syntax enable

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

" noremap
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>
nnoremap <Leader>r :<C-U>QuickRun<CR>

call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

" spellbadの色が鬱陶しいので変える
autocmd ColorScheme * highlight SpellBad ctermbg=235 guibg=403D3D ctermfg=239 guifg=#465457
set background=dark
let g:hybrid_use_iTerm_colors = 1
syntax enable
colorscheme hybrid

" syntax highlighting
filetype plugin indent on

" Go
let mapleader = "\<Space>"
au FileType go nmap <leader>s <Plug>(go-def-split)
au FileType go nmap <leader>v <Plug>(go-def-vertical)
let g:go_metalinter_autosave = 1

" autofmt
:set formatexpr=autofmt#japanese#formatexpr()  " kaoriya版では設定済み
:let autofmt_allow_over_tw=1                   " 全角文字がぶら下がりで1カラムはみ出すのを許可

:let g:previm_open_cmd = 'open -a Safari'

" LSP settings
" "ray-x/go.nvim
"autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()
"lua << EOF
"require'lspconfig'.gopls.setup{}
"require "lsp_signature".setup({
"    bind = true, -- This is mandatory, otherwise border config won't get registered.
"    handler_opts = {
"      border = "rounded"
"    }
"  })
"EOF
"
set completeopt=menu,menuone,noselect
lua << EOF
local lsp_installer = require("nvim-lsp-installer")
local servers = {
  "gopls",
}

lsp_installer.on_server_ready(function(server)
  local opts = {}

  -- `sumneko_lua` をinstallしているなら `hello world` を表示します。
  if server.name == 'sumneko_lua' then
    print('hello world')
  end

  -- serverに対応しているfiletypeのbufferを開いたら、
  -- 実行するfunctionを設定します。
  -- sumneko_luaはluaのLSP serverなので、
  -- luaのbufferを開いたら、実行するfunctionです。
  opts.on_attach = function(client,buffer_number)
    print(vim.inspect(client))
    print(buffer_number)
  end

  -- LSPのsetupをします。
  -- setupをしないとserverは動作しません。
  server:setup(opts)
end)

  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'ultisnips' }, -- For ultisnips users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['gopls'].setup {
    capabilities = capabilities
  }
EOF
