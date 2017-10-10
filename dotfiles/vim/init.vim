 " For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
if (has("termguicolors"))
 set termguicolors
endif

 " Theme
syntax enable   " enable syntax processing
"colorscheme OceanicNext
let g:neosolarized_contrast = "low"
set background=dark

if has('mouse') | set mouse=a | endif

let mapleader = "," " leader key is ,

 " On save, remove trailing space
autocmd BufWritePre * %s/\s\+$//e

"""""""""""""""
"" UI Config. "
"""""""""""""""
set noshowmode " Do not display "-- INSERT --" as it is handled by lightline
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }
  "The following lets searches be incremental.  So in normal mode, /sec will go to the first 'section', for example.  I don't have to type /section for that:
set incsearch " search as characters are entered
set hlsearch  " highlight matches
" turn off search highlight with leader+space
nnoremap <leader>n :nohlsearch<CR>

    " Vim window stuff
  "I'm pretty sure this makes wrapped lines break at spaces, not in the middle of words:
set linebreak
  " Insert a new line after textwidth characters
set textwidth=100

  "I like to see line numbers:
set number

  "Highlight the line that the cursor is on:
set cursorline

  "Show the command you are currently typing
set showcmd

filetype indent on " load filetype-specific indent files

set wildmenu " visual autocomplete for command menu

"set list " Display invisible character on new line

"set showmatch " highlight matching [{()}]

  "Activate spell check
setlocal spell spelllang=en_us
set nospell
  " "CTRL+l l" will open the list of alternatives
map <C-l>l z=
  " "CTRL+l n" go to the next misspelled word
map <C-l>n ]s
  " "CTRL+l a" zg add the current word to the dictionary
map <C-l>a zg

"""""""""""
" SPACING "
"""""""""""
  "If you are indented and start a new line, this makes the new line indented, too. Peux toujours être désactivé par "set noai"
set autoindent

  "These deal with what the TAB key inserts.  I set my tabs to be only two spaces wide (default is 4).  The second one makes sure the shift function knows this (you use that by selecting some text and hitting > for multiple lines and >> for a single line.  The last one converts TAB characters into spaces instead of TAB characters.  (Apparently this is big to programmers, I use it to follow conventions in the Ruby programming language.
set tabstop=2     " number of visual spaces per TAB
set softtabstop=2 " number of spaces in tab when editing
set shiftwidth=2  " how many columns text is indented with the reindent operations (<< and >>)
set expandtab     " tabs are spaces

" https://vi.stackexchange.com/questions/509/can-i-justify-text-in-vim
packadd! justify   " using the shortcut _j justify the selected block of text
" CTRL+j to split the text at `textwidth` length
map <C-j> gq

"""""""""""
" PLUGIN  "
"""""""""""
call plug#begin()
Plug 'itchyny/lightline.vim'
Plug 'iCyMind/NeoSolarized'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'mileszs/ack.vim'          " Grep into a project source code
Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'kchmck/vim-coffee-script' " Coffee script
Plug 'mustache/vim-mustache-handlebars' " Handlebars
Plug 'gabrielelana/vim-markdown' " Markdown
Plug 'lervag/vimtex'             " LaTeX
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } " Go language
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'fishbullet/deoplete-ruby'
Plug 'ngmy/vim-rubocop'
Plug 'tpope/vim-rails'          " Rails
call plug#end()
colorscheme NeoSolarized

"""""""""""
" Neomake "
"""""""""""
let g:syntastic_ruby_checkers = ['rubocop', 'mri']
let g:neomake_ruby_enabled_makers = ['rubocop', 'mri']
autocmd! BufWritePost * Neomake

""""""""""""
" NerdTREE "
""""""""""""
map <C-n> :NERDTreeToggle<CR>
let NERDTreeMapOpenVSplit='v'
let NERDTreeMapOpenSplit='h'

"""""""""
" CtrlP "
"""""""""
" Ctrl + p activate the fuzzy search
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("h")': ['<c-h>', '<c-s>'],
  \ }

"""""""
" Ack "
"""""""
nnoremap <leader>g :Ack

""""""""""
" vim-go "
""""""""""
set autowrite " Automatically save the file if GoBuild is called
let g:go_list_type = "quickfix" "

" Coloration syntaxique
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1

" Whenever we save, call
let g:go_fmt_command = "goimports"
" let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave_enabled = ['vet', 'errcheck']
let g:go_metalinter_autosave = 1 " Use the above-mentioned linter at each save

" Keyboard shortcut
	" next and previous error
map <C-g>b :cprevious<CR>
map <C-g>n :cnext<CR>
	" close error panel
nnoremap <C-g>q :cclose<CR>
	" Jump to declarations
nnoremap <C-g>d :GoDecls<CR>
	" Jump to declarations in current directory
nnoremap <C-g>D :GoDeclsDir<CR>
	" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
	let l:file = expand('%')
	if l:file =~# '^\f\+_test\.go$'
		call go#cmd#Test(0, 1)
	elseif l:file =~# '^\f\+\.go$'
		call go#cmd#Build(0)
	endif
endfunction
autocmd FileType go nmap <C-b> :<C-u>call <SID>build_go_files()<CR>

" Deoplete configuration
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

let g:deoplete#sources#go#pointer = 1 " Support pointer (*) match.
