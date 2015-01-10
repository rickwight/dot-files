runtime! debian.vim
syntax on
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif
if has("autocmd")
  filetype indent on
"  set autoindent    " always set autoindenting on
endif
set incsearch   " Incremental search
set hlsearch
set expandtab
set softtabstop=2


" Display filename in tab title
set title

" Show line numbers
set nu

" Custom file types
au BufEnter *.thpl setfiletype perl
au BufEnter *.slsl setfiletype python
au BufEnter *.h setfiletype cpp
au BufEnter *.cpp setfiletype cpp
au BufEnter *.cc setfiletype cpp
au BufEnter *.ut setfiletype cpp


" Language specific options
autocmd FileType * set softtabstop=2 | set ts=2 | set sw=2
autocmd FileType python set softtabstop=4 | set ts=4 | set sw=4
autocmd FileType cpp set softtabstop=4 | set ts=4 | set sw=4
autocmd FileType python syntax match pythonSelf /self/
autocmd FileType python syntax match pythonMock /Mock/
autocmd FileType perl syntax match perlConst /[A-Z]\w*/
autocmd FileType perl syntax match perlKeyWords /\Wtry\W/
autocmd FileType perl syntax match perlKeyWords /\Wcatch\W/
autocmd FileType perl syntax match perlKeyWords /\Wwith\W/


" Custom Highlighting groups
highlight link pythonSelf String
highlight link pythonMock Structure
highlight link perlConst Type
highlight link perlKeyWords Special

highlight ExtraWhitespace guibg=red ctermbg=red
match ExtraWhitespace /\s\+$/


"au BufEnter *.c setl noexpandtab softtabstop=4
"au BufEnter *.rb setl expandtab softtabstop=2

" Lower timeout to make shift-O wait less after an escape
set timeout timeoutlen=1000 ttimeoutlen=100

set wildmode=longest,list
set mouse=a

set nocompatible
set backspace=indent,eol,start
set ruler   " show the cursor position all the time
"if has('mouse')
"  set mouse=a
"endif

" F7: Toggle list mode (aka. visible whitespace)
set listchars=tab:>-,trail:·,eol:$
nnoremap \tl :set invlist list?<CR>
nmap <F7> \tl

" F1: set mouse=a
map <F2> :set mouse=a nopaste<CR>
map <F3> :set mouse=r paste<CR>

"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%101v.\+/
