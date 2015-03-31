
" =========================================
" |                               Vundle                                    |
" |                          Must be on top
" =======================================

filetype on   " first on, to avoid vim exiting with status code 1!
filetype off  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" We might implement https://github.com/junegunn/vim-plug/

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" Original repos on github
Bundle 'Townk/vim-autoclose'
Bundle 'docunext/closetag.vim'
Bundle 'ervandew/supertab'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'kien/ctrlp.vim'
Bundle 'mattn/emmet-vim'
Bundle 'mileszs/ack.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/matchit.zip'

" Y U No Commit
Bundle 'esneider/YUNOcommit.vim'

" Coffeescript
Bundle 'kchmck/vim-coffee-script'

" Javascript
Bundle "pangloss/vim-javascript"

" Haskell
" Install stylish-haskell via cabal
Bundle 'nbouscal/vim-stylish-haskell'
Bundle 'lukerandall/haskellmode-vim'

" Go
Bundle 'fatih/vim-go'

" Formats
Plugin 'godlygeek/tabular' " needed for markdown
Bundle 'tpope/vim-markdown'
" Bundle 'tpope/vim-haml'
Bundle 'cespare/vim-toml'
Bundle 'nono/vim-handlebars'
Bundle 'ingydotnet/yaml-vim'
Bundle 'php.vim-html-enhanced'

Bundle 'bling/vim-airline'
Bundle 'paranoida/vim-airlineish'

" Bundle 'tpope/vim-fugitive'
" Bundle 'gregsexton/gitv'
Bundle 'airblade/vim-gitgutter'

" vim-scripts repos
Bundle 'L9'
Bundle 'tComment'
Bundle 'EasyMotion'

" ===========================================
" General
" ===========================================

" map : to ; for qwerty
noremap ; :

" == Disable arrow keys =============================

inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" == Bootstrap ======================================

set encoding=utf8
set laststatus=2        " Always show the statusline
set nocompatible        " the future is now, use vim defaults instead of vi ones

syntax on               " Enable syntax highlighting
syntax enable 		      " Enable syntax hl

filetype on             " /!\ doesn't play well with compatible mode
filetype plugin on      " trigger file type specific plugins
filetype indent on      " indent based on file type syntax

set number              " Line number
set hidden

set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set cmdheight=1         " height of the command line
set showmatch           " Show matching bracets when text indicator is over them
set clipboard=unnamed   " Yank everything to the system clipboard

highlight NonText guifg=#7A7A90   " Invisible character colors
highlight SpecialKey guifg=#7A7A90

set history=1000        " keep 1000 lines of command line history
set undolevels=200      " Undo history
set ttyfast             " Yes, we have a fast terminal
set title               " change the terminal title
set lazyredraw          " do not redraw when executing macros
set report=0            " always report changes

" == Editing =====================================

set nowrap                      " don't wrap lines
set nojoinspaces                " insert only one space after '.', '?', '!' when joining lines
set showmatch                   " briefly jumps the cursor to the matching brace on insert
set matchtime=4                 " blink matching braces for 0.4s
set backspace=indent,eol,start  " allow backspacing over everything
fixdel

set softtabstop=2
set shiftwidth=2                " indent with 2 spaces
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set tabstop=2
set expandtab
set wrap                        " set linewrap

set lbr
set tw=500
set autoindent
set smartindent
set copyindent                  " Take indentation from previous line

" set list                      " Show invisible characters
set listchars=""                " Reset the listchars
set listchars=tab:»·,trail:·,eol:¬,nbsp:_

" reselect last selection after indent / un-indent in visual and select modes
vnoremap < <gv
vnoremap > >gv
vmap <Tab> >
vmap <S-Tab> <

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=256

" allow multiple pastes of the same content when pasting in visual mode.
vnoremap p pgvy

" == Silver Searcher ===========================

" Ag
" brew install the_silver_searcher
" pacman -S the_silver_searcher
" apt-get install silversearcher-ag
let g:ackprg = 'ag --nogroup --nocolor --column'

" Allow lowercase ack in case of misspelling
cnoreabbrev <expr> ack getcmdtype() == ':' && getcmdline() ==# 'ack' ? 'Ack' : 'ack'

" == Buffers ==================================

set autoread         " Set to auto read when a file is changed from the outside
set nobomb           " don't clutter files with Unicode BOMs
set hidden           " enable switching between buffers without saving
set switchbuf=usetab " switch to existing tab then window when switching buffer
set fsync            " sync after write
set confirm          " ask whether to save changed files

if has("autocmd")
  augroup trailing_spaces
    " autocmd!
    autocmd BufWritePre * :%s/\s\+$//e " remove trailing spaces before saving
  augroup END
  " augroup restore_cursor
  "   " restore cursor position to last position upon file reopen
  "   autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
  " augroup END
endif

" == Folding =======================================

if has("folding")
  set foldenable
  set foldmethod=syntax   " fold based on indent
  set foldlevelstart=99   " start editing with all folds open
  set foldnestmax=3       " deepest fold is 3 levels
  set nofoldenable        " dont fold by default
endif

" == Completion ==================================

set completeopt=longest,menuone,preview             " better completion
set wildmenu                                        " enable ctrl-n and ctrl-p to scroll thru matches
set wildmode=longest:full,list:longest
set wildignore=*.o,*.obj,*~                         " stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=.git                                " ignore the .git directory
set wildignore+=*.DS_Store                          " ignore Mac finder/spotlight crap
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.DS_Store

if exists("&wildignorecase")
  set wildignorecase
endif

" == Color + font ===================================

colorscheme default
set ffs=unix,mac,dos	  " Support all three, in this order

" == Git/SVN Errors =====================================

match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" == Filetypes =======================================

au BufRead,BufNewFile *.module            set filetype=php
au BufRead,BufNewFile *.inc               set filetype=php
au BufRead,BufNewFile *.install           set filetype=php

au BufRead,BufNewFile *.less              set filetype=css
au BufRead,BufNewFile *.json              set filetype=javascript
au BufRead,BufNewFile *.handlebars,*.hbs  set filetype=handlebars
au BufRead,BufNewFile *.tmpl              set filetype=html

au BufRead,BufNewFile *.go                set filetype=go
au BufRead,BufNewFile *.ru                set filetype=ruby

" Haskell
autocmd FileType haskell setlocal expandtab shiftwidth=2 softtabstop=2
au Bufenter *.hs,*.lhs compiler ghc

" Extra syntax highlighting
au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby

" Spell check certain filetypes (eg Markdown)
autocmd BufRead,BufNewFile *.md   setlocal spell
autocmd BufRead,BufNewFile *.txt  setlocal spell

" == Search improvements =======================

set hlsearch                " Highlight search things
set incsearch               " Make search act like search in modern browsers
set ignorecase              " Case insensitive matching...
set smartcase               " ... unless they contain at least one capital letter

" == Files/backup ==================================

set nobackup                " do not keep a backup file, use versions instead
set nowb
set noswapfile

" == Visualbell ===================================

set visualbell              " shut up
set noerrorbells            " shut up
set mousehide               " hide mouse pointer when typing

" == Syntastic =========================

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_enable_signs=1    " show signs in bar
let g:syntastic_quiet_messages = {'level': 'warnings'}

let g:syntastic_mode_map = {  'mode': 'active',
                            \ 'active_filetypes': [],
                            \ 'passive_filetypes': ['sass', 'scss']}
nmap <F3> :SyntasticCheck<CR>     " do check

autocmd BufEnter * :syntax sync fromstart

" == Statusline =========================

function! CurDir()
  let curdir = substitute(getcwd(), '/Users/', "~/..", "g")
  return curdir
endfunction

function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  else
    return ''
  endif
endfunction

" == Mouse =============================

" Enable mouse in all modes. -> https://bitheap.org/mouseterm/
set mouse=a

" Set mouse type to xterm.
set ttymouse=xterm

" == Airline =========================

set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline) "
let g:airline_powerline_fonts=1
set ttimeoutlen=50
let g:airline_theme = 'airlineish'
" let g:airline_theme = 'luna'

" == Source after saving ================

if has("autocmd")
  autocmd! BufWritePost .vimrc nested source $MYVIMRC | echo "source $MYVIMRC"
endif

" == Keyboard mapping ==================

" Professor VIM says '87% of users prefer jj over esc'
imap jj <Esc>
let mapleader = ","

" Show/hide hidden characters
nmap <leader>l :set list!<cr>

" Clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

" Clean whitespace
command! KillWhitespace :call <SID>StripTrailingWhitespaces()<CR>
nnoremap <silent> <leader>w :call <SID>StripTrailingWhitespaces()<CR>

function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Clean windows weird characters
command! CleanWindowsShit :call CleanWindowsCharacters()<CR>

function! CleanWindowsCharacters()
  :%s/\\//g
endf

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

if has("gui_running") " Fuck you, help key, seriously
  set fuoptions=maxvert,maxhorz
endif

noremap  <F1> :set invfullscreen<CR>
inoremap <F1> <ESC>:set invfullscreen<CR>

" switch between last two files
nnoremap <leader><Tab> <c-^>

" move to the position where the last change was made
noremap gI `.

" split line and preserve cursor position
nnoremap S mzi<CR><ESC>`z

" == Paste mode ===============================

nnoremap <F2> :set invpaste paste?<CR> " Enable F2 key for toggling pastemode
imap <F2> <C-O><F2>
set pastetoggle=<F2>

" == HTML ===============================

:vmap <leader><leader>b <S-S><strong>
:vmap <leader><leader>i <S-S><em>

" convert list of lines to <li>
map <leader><leader>l :s/\s\+$//e<CR>:'<,'>s/^/<li>/g<CR>:'<,'>s/$/<\/li>/g<CR>:nohl<CR>

" == Fugitive ===========================

nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Git pull<CR>
nnoremap <silent> <leader>glod :Git pull origin develop<CR>
nnoremap <silent> <leader>glom :Git pull origin master<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gr :Gread<CR>:GitGutter<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>:GitGutter<CR>
nnoremap <silent> <leader>ge :Gedit<CR>
nnoremap <silent> <leader>gg :GitGutterToggle<CR>

" == Nerdtree ================================

nmap <silent> <c-n> :NERDTreeToggle \| :silent NERDTreeMirror<CR>

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" set autochdir
let NERDTreeChDirMode = 1
let NERDChristmasTree = 1

" == CtrlP ==================================

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

let g:ctrlp_custom_ignore = '\.(git|hg|svn)$\|\.(o|swp|pyc|wav|mp3|ogg|blend|jpg|png|gif|psd|ai|svg)$\|node_modules\|DS_Store\|git\|min'

map <leader>cp :CtrlPClearCache<CR>

" == Emmet (previously Zencoding ===========

" imap <c-e> <c-y>,
let g:use_emmet_complete_tag = 1
let g:user_emmet_leader_key = '<c-e>'

" == Switch files ========================

nmap <c-h> <ESC>:bp<CR>
nmap <c-l> <ESC>:bn<CR>

" == EasyMotion =========================

let g:EasyMotion_leader_key = '<Leader>'

" == SuperTab ==========================

" let g:SuperTabDefaultCompletionType = "context"
" let g:SuperTabContextDefaultCompletionType = "<c-n>"

" == Split windows ====================

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" switch between windows by hitting <Tab> twice
nmap <silent> <Tab><Tab> <C-w>w

" enlarge splits
map + 3<c-w>>
map - 3<c-w><

" == Search ==========================

" show number of matches after a search
nmap <leader>c :%s///gn<cr>

" == Golang ============================

" Clear filetype flags before changing runtimepath to force Vim to reload them.
filetype off
filetype plugin indent off

set runtimepath+=$GOROOT/misc/vim

filetype plugin indent on
syntax on
syntax enable

let g:go_bin_path = expand("$HOME/.vim-go/")
let g:go_disable_autoinstall = 0

" == Y U No Commit  ====================
let g:YUNOcommit_after = 20

" == Highlight =========================
" Highlight words to avoid in production

highlight TechWordsToAvoid ctermbg=red ctermfg=white
match TechWordsToAvoid /\cconsole\|var_dump\|print_r\|alert/
autocmd BufWinEnter * match TechWordsToAvoid /\cconsole\|var_dump\|print_r\|alert/
autocmd InsertEnter * match TechWordsToAvoid /\cconsole\|var_dump\|print_r\|alert/
autocmd InsertLeave * match TechWordsToAvoid /\cconsole\|var_dump\|print_r\|alert/
autocmd BufWinLeave * call clearmatches()

" == User defined =====================

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
