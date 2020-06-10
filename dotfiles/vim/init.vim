 " For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set t_Co=256
if (has("termguicolors"))
 set termguicolors
endif

syntax enable   " enable syntax processing
set background=dark

if has('mouse') | set mouse=a | endif

let mapleader = "," " leader key is ,

 " Copy in the system buffer with CTRL+c
vnoremap <C-C> "+y

 " reload the configuration file
map <leader>s :source ~/.config/nvim/init.vim<CR>

 " On save, remove trailing space
autocmd BufWritePre * %s/\s\+$//e

 " Keep more info in memory to speed things up:
set hidden
set history=100

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

" turn off search highlight with leader + n
nnoremap <leader>n :nohlsearch<CR>

    " Vim window stuff
  "I'm pretty sure this makes wrapped lines break at spaces, not in the middle of words:
set linebreak
  " Insert a new line after textwidth characters
set textwidth=80

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

  " Default spell check language is English
setlocal spell spelllang=en_us
set nospell
  " "CTRL+l l" will open the list of alternatives
map <C-l>l z=
  " "CTRL+l n" go to the next misspelled word
map <C-l>n ]s
  " "CTRL+l a" zg add the current word to the dictionary
map <C-l>a zg

  " \x closes the quick fix window
nmap <leader>q :cclose<CR>

" Display comments in italic
" https://rsapkf.netlify.com/blog/enabling-italics-vim-tmux
" highlight Comment cterm=italic

"""""""""""
" SPACING "
"""""""""""
  "If you are indented and start a new line, this makes the new line indented, too. Peux toujours être désactivé par "set noai"
set autoindent

  "These deal with what the TAB key inserts.  I set my tabs to be only two spaces wide (default is
  "4).  The second one makes sure the shift function knows this (you use that by selecting some text
  "and hitting > for multiple lines and >> for a single line.  The last one converts TAB characters
  "into spaces instead of TAB characters.  (Apparently this is big to programmers, I use it to
  "follow conventions in the Ruby programming language.
set tabstop=2     " number of visual spaces per TAB
set softtabstop=2 " number of spaces in tab when editing
set shiftwidth=2  " how many columns text is indented with the reindent operations (<< and >>)
set expandtab     " tabs are spaces

" https://vi.stackexchange.com/questions/509/can-i-justify-text-in-vim
packadd! justify   " using the shortcut _j justify the selected block of text
" CTRL+j to split the text at `textwidth` length
map <C-j> gq

" Show spaces and tabs
" Inserting an unbreakable space is a matter of entering in insert mode and type
" <C-k> space space
:set list
:hi NonText ctermfg=7 guifg=gray25

"""""""""""
" PLUGIN  "
"""""""""""
call plug#begin()
Plug 'itchyny/lightline.vim'
Plug 'iCyMind/NeoSolarized'
Plug 'chriskempson/base16-vim'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'mileszs/ack.vim'          " Grep into a project source code
Plug 'airblade/vim-gitgutter'   " Display marker in front of modified lines
Plug 'rhysd/vim-grammarous'     " Grammar checking
Plug 'majutsushi/tagbar'
Plug 'junegunn/vim-easy-align'   " To make markdown table
" I replaced ALE with Neomake which successfully display the error message in Go
" file. But I might need to do some configuration to run Prettier on save on JS
" files.
" Plug 'w0rp/ale'
Plug 'neomake/neomake'
Plug 'tomtom/tcomment_vim'

" Deoplete is an asynchronous completion framework
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
" Plug 'fishbullet/deoplete-ruby'

Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'ngmy/vim-rubocop'
Plug 'tpope/vim-rails'
Plug 'spacewander/openresty-vim'
Plug 'sheerun/vim-polyglot'

" Plug 'gabrielelana/vim-markdown'
" Plug 'lervag/vimtex'             " LaTeX
" Plug 'mdempsky/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
" Plug 'jodosha/vim-godebug'
Plug 'hashivim/vim-terraform'
" Plug 'posva/vim-vue'
" Plug 'pangloss/vim-javascript'
call plug#end()

"colorscheme NeoSolarized
colorscheme base16-default-dark
let g:neosolarized_contrast = "low"

" Max text width is 80 for markdown files.
" For an unkown reason these type of files do not use the global settings.
" Probably because of a plugin...
au FileType markdown setlocal textwidth=80
au FileType sh setlocal textwidth=120
au FileType pullrequest setlocal textwidth=0

"""""""
" ALE "
"""""""
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

""""""""""""""
" Grammarous "
""""""""""""""
" Open grammar info window
nmap <leader>a <Plug>(grammarous-move-to-info-window)
" Go to next grammar error
nmap <leader>z <Plug>(grammarous-move-to-next-error)
" Fix current grammar error
nmap <leader>e <Plug>(grammarous-fixit)

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
" Ignore files included in the .gitignore file
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files --cached --others --exclude-standard']

"""""""
" Ack "
"""""""
cnoreabbrev Ack Ack!
nnoremap <leader>g :Ack!<Space>

"""""""""""""
" GitGutter "
"""""""""""""
" GitGutter styling to use · instead of +/-
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'

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
let g:go_fmt_options = {
  \ 'gofmt': '-s',
  \ 'goimports': '-local github.com/Scalingo',
  \ }
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
" The following lines are now handled asynchronously by Neomake
" let g:go_metalinter_autosave_enabled = ['vet', 'errcheck']
" let g:go_metalinter_autosave = 1 " Use the above-mentioned linter at each save
let g:go_decls_includes = "func,type" " GoDecls gives functions and types names
let g:go_auto_type_info = 0 " Set to 1 to automatically fetch the signature of everything

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
	" Toggle current file coverage
nnoremap <C-g>c :GoCoverageToggle<CR>
	" Execute the current test function
nnoremap <C-g>t :GoTestFunc<CR>
	" Test the package
nnoremap <C-g>T :GoTest<CR>
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

""""""""""
" Tagbar "
""""""""""
nmap <leader>t :TagbarToggle<CR>

"""""""""""
" RuboCop "
"""""""""""
nmap <Leader>w :RuboCop --auto-correct<CR>

"""""""""""""
" EasyAlign "
"""""""""""""
au FileType markdown vmap <Leader>t :EasyAlign*<Bar><Enter>

"""""""""""""
" Terraform "
"""""""""""""
let g:terraform_align=1
let g:terraform_fmt_on_save=1

"""""""""""""
" OpenResty "
"""""""""""""
autocmd BufRead,BufNewFile nginx-*.conf set filetype=nginx

""""""""""""
" Prettier "
""""""""""""
" Run Prettier on save and when leaving the insert mode
" let g:ale_fixers = {
" \   'javascript': ['prettier'],
" \   'typescript': ['prettier'],
" \   'vue': ['prettier'],
" \   'css': ['prettier'],
" \}
" let g:ale_fix_on_save = 1

"""""""""""
" Neomake "
"""""""""""
let g:neomake_ruby_enabled_makers = ['rubocop', 'mri']
highlight NeomakeVirtualtextError guifg=red
" Start Neomake on save
autocmd! BufWritePost * Neomake
