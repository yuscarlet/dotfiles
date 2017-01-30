" Setting of NeoBundle
" --------------------------------------------------------
set nocompatible               " be iMproved
filetype off
if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
"call neobundle#rc(expand('~/.vim/bundle/'))
call neobundle#begin(expand('~/.vim/bundle/'))

" originalrepos on github
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'VimClojure'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Align'
NeoBundle 'Shougo/vinarise'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'vimtaku/hl_matchit.vim.git'
NeoBundle "matchit.zip"
NeoBundleCheck
NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()
filetype plugin indent on     " required!
filetype indent on

" ハイライトを有効にする
let g:hl_matchit_enable_on_vim_startup = 1

" Setting of neocomplcache
" --------------------------------------------------------
"Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

"let g:neosnippet#disable_runtime_snippets = { "_": 1, }

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
			\ 'default' : ''
			\ }
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()
" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function()
"	return neocomplcache#smart_close_popup() . "\<CR>"
"endfunction

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Setting of syntax options.
" --------------------------------------------------------
syntax on
set showcmd nolist hlsearch ignorecase smartcase incsearch nowrap
set listchars=tab:>-,extends:<,trail:-,eol:<
set backspace=indent,eol,start
set number
set wildmenu
set modeline
set nocompatible cursorline
set noautoindent
"colorscheme molokai
colorscheme hybrid
set t_ut=
set background=dark

" Setting of backup/swap options.
" --------------------------------------------------------
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set swapfile

" Setting of tab options.
" --------------------------------------------------------
set tabstop=2
set softtabstop=0
set shiftwidth=2

" Hide start up message.
" --------------------------------------------------------
set shortmess+=I

" Setting an unlimited number of text width
" --------------------------------------------------------
set textwidth=0

" move seamlessly between the lines
" --------------------------------------------------------
set whichwrap+=h,l

" Setting of input option
" --------------------------------------------------------
set iminsert=0
set imsearch=0

" Use mouse.
" --------------------------------------------------------
set mouse=a
set ttymouse=xterm2

" Setting of search option
" --------------------------------------------------------
set history=100
set ignorecase
set smartcase
set wrapscan
set noincsearch

" Setting of shortcut key.
" --------------------------------------------------------
nnoremap <silent> v<S-b> /{<CR>%v%0
nnoremap <silent> <S-i> "="\n"<CR>pi
nnoremap <silent> O "="\n"<CR>p<UP>
nnoremap <silent> <ESC><ESC> :noh<CR>
nnoremap / :noh<CR> /
autocmd FileType help nnoremap <buffer> q <C-w>c
nnoremap <C-h> :help<CR>
nnoremap <C-h><C-h> :help <C-r><C-w><CR>

" Show spaces
" --------------------------------------------------------
highlight WhitespaceAtEndOfline ctermbg=red guibg=red
match WhitespaceAtEndOfline /[ \t][ \t]*$/
highlight ZenkakuSpace cterm=underline ctermfg=yellow guifg=yellow ctermbg=red guibg=red
au BufWinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')
au WinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')

" StatusLine settings
" --------------------------------------------------------
set laststatus=2
" for lightline.vim --------------------
let g:lightline = {
			\ 'colorscheme': 'jellybeans',
			\ 'component': {
			\   'readonly': '%{&readonly?"RO":""}',
			\ },
			\ 'active': {
			\   'right': [ [ 'syntastic', 'lineinfo' ],
			\              [ 'percent' ],
			\              [ 'fileformat', 'fileencoding', 'filetype' ] ]
			\ },
			\ 'component_expand': {
			\   'syntastic': 'SyntasticStatuslineFlag'
			\ },
			\ 'component_type': {
			\   'syntastic': 'error'
			\ }
			\ }

let g:syntastic_mode_map = { 'mode': 'passive' }
augroup AutoSyntastic
	autocmd!
	autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
	SyntasticCheck
	call lightline#update()
endfunction

"  Binary edit by xxd
"  if be ran with "-b" option or open *.bin files
" --------------------------------------------------------
augroup BinaryXXD
	autocmd!
	autocmd BufReadPre   *.bin let &binary = 1
	autocmd BufReadPost  * if &binary | silent %!xxd
	autocmd BufReadPost  * set ft=xxd | endif
	autocmd BufWritePre  * if &binary | %!xxd -r
	autocmd BufWritePre  * endif
	autocmd BufWritePost * if &binary | silent %!xxd
	autocmd BufWritePost * set nomod  | endif
augroup END

" Make parent directory if it isn't existed.
"--------------------------------------------------------
augroup AutoMkdir
	au!
	au BufNewFile * call PromptAndMakeDirectory()
augroup END

function! PromptAndMakeDirectory()
	let dir = expand("<afile>:p:h")
	if !isdirectory(dir) && confirm("Create a new directory [".dir."]?", "&Yes\n&No") == 1
		call mkdir(dir, "p")
		" Reset fullpath of the buffer in order to avoid problems when using autochdir.
		file %
	endif
endfunction

set encoding=utf-8
set fileencodings=utf8,iso-2022-jp,euc-jp,sjis
" Char-set auto recognize
"--------------------------------------------------------
"if &encoding !=# 'utf-8'
"	set encoding=japan
"	set fileencoding=japan
"endif
"if has('iconv')
"	let s:enc_euc = 'euc-jp'
"	let s:enc_jis = 'iso-2022-jp'
"	" iconvがeucJP-msに対応しているかをチェック
"	if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
"		let s:enc_euc = 'eucjp-ms'
"		let s:enc_jis = 'iso-2022-jp-3'
"		" iconvがJISX0213に対応しているかをチェック
"	elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
"		let s:enc_euc = 'euc-jisx0213'
"		let s:enc_jis = 'iso-2022-jp-3'
"	endif
"	" fileencodingsを構築
"	if &encoding ==# 'utf-8'
"		let s:fileencodings_default = &fileencodings
"		let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
"		let &fileencodings = &fileencodings .','. s:fileencodings_default
"		unlet s:fileencodings_default
"	else
"		let &fileencodings = &fileencodings .','. s:enc_jis
"		set fileencodings+=utf-8,ucs-2le,ucs-2
"		if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
"			set fileencodings+=cp932
"			set fileencodings-=euc-jp
"			set fileencodings-=euc-jisx0213
"			set fileencodings-=eucjp-ms
"			let &encoding = s:enc_euc
"			let &fileencoding = s:enc_euc
"		else
"			let &fileencodings = &fileencodings .','. s:enc_euc
"		endif
"	endif
"	" 定数を処分
"	unlet s:enc_euc
"	unlet s:enc_jis
"endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
	function! AU_ReCheck_FENC()
		if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
			let &fileencoding=&encoding
		endif
	endfunction
	autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
	set ambiwidth=double
endif

function! s:format_file()
	let view = winsaveview()
	normal gg=G
	silent call winrestview(view)
endfunction


