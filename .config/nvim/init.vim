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
" サインカラム（行番号の左側に表示される警告やエラーマーク用のカラム）を常に表示し、2列にする
" デバッグ情報などを見やすくする
set signcolumn=yes:2
" アンドゥ情報をファイルとして保存する
set undofile
" NeoVimのウィンドウタイトルに現在のファイル名やステータスを表示する
set title
" 検索時に大文字小文字を区別しないようにする
set ignorecase
" 検索時にクエリに大文字が含まれている場合は大文字小文字を区別する
set smartcase
" コマンドライン補完の動作を設定する
" longest:full,fullにより、最長マッチの補完を行った後、候補全てを表示する
set wildmode=longest:full,full
" マウスの全機能を有効にする
set mouse=a
" カーソルが画面端に近づいたときに、上下に少なくとも8行の余白を保つ
set scrolloff=8
" 垂直分割（:vsplit）をした際に、新しいウィンドウを現在のウィンドウの右側に開くようにする
set splitright
" システムのクリップボードを使用する
set clipboard=unnamedplus

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
" Vim上でGitコマンドを実行できるようにする
Jetpack 'tpope/vim-fugitive',
" gitのdiffを表示する
Jetpack 'airblade/vim-gitgutter',

" 以下LCP用プラグイン
Jetpack 'neovim/nvim-lspconfig',
Jetpack 'williamboman/mason.nvim',
Jetpack 'williamboman/mason-lspconfig.nvim',
Jetpack 'hrsh7th/nvim-cmp',
Jetpack 'hrsh7th/cmp-nvim-lsp',
Jetpack 'hrsh7th/vim-vsnip',
call jetpack#end()

" LCP設定
lua << EOF
-- 1. LSP Sever management
require('mason').setup()
require('mason-lspconfig').setup_handlers({ function(server)
  local opt = {
    -- -- Function executed when the LSP server startup
    -- on_attach = function(client, bufnr)
    --   local opts = { noremap=true, silent=true }
    --   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    --   vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.format(nil, 1000)'
    -- end,
    capabilities = require('cmp_nvim_lsp').default_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )
  }
  require('lspconfig')[server].setup(opt)
end })

-- 2. build-in LSP function
-- keyboard shortcut
vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.format()<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
-- Reference highlight
vim.cmd [[
set updatetime=500
highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
]]

-- 3. completion (hrsh7th/nvim-cmp)
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    -- { name = "buffer" },
    -- { name = "path" },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
  }),
  experimental = {
    ghost_text = true,
  },
})
-- cmp.setup.cmdline('/', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = 'buffer' }
--   }
-- })
-- cmp.setup.cmdline(":", {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = "path" },
--     { name = "cmdline" },
--   },
-- })
EOF
