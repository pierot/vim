" Jack + Joe do vim, since 2012
"
" Last major rework updated reflecting
" http://dougblack.io/words/a-good-vimrc.html " Vim needs a POSIX-Compliant shell. Fish is not.
if $SHELL =~ 'bin/fish'
  set shell=/bin/sh
endif

" Vundle must be first
" Vundle {{{
filetype on   " first on, to avoid vim exiting with status code 1!
filetype off  " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" We might implement https://github.com/junegunn/vim-plug/
" }}}

" Plugins {{{
Plugin 'VundleVim/Vundle.vim'

Plugin 'jiangmiao/auto-pairs'
Plugin 'docunext/closetag.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'

Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'mileszs/ack.vim'

Plugin 'w0rp/ale'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-obsession'
Plugin 'ervandew/supertab'
Plugin 'kana/vim-textobj-user'
" Plugin 'kana/vim-textobj-entire'
Plugin 'kana/vim-textobj-line'
Plugin 'andyl/vim-textobj-elixir'
Plugin 'junegunn/vim-easy-align'
Plugin 'janko-m/vim-test'

Plugin 'bling/vim-airline'

" Snippets
if has('nvim')
  Plugin 'SirVer/ultisnips'
  Plugin 'honza/vim-snippets'
  Plugin 'rstacruz/vim-ultisnips-css'

  " deoplete
  Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plugin 'roxma/nvim-yarp'
  Plugin 'roxma/vim-hug-neovim-rpc'
else
  Plugin 'ajh17/VimCompletesMe'
endif

" Javascript
Plugin 'pangloss/vim-javascript'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'mxw/vim-jsx'
Plugin 'prettier/vim-prettier', { 'do': 'yarn install' }

" Elixir
Plugin 'elixir-editors/vim-elixir'
Plugin 'mhinz/vim-mix-format'

" Golang
Plugin 'fatih/vim-go'

" Formats
Plugin 'tpope/vim-markdown'
Plugin 'cespare/vim-toml'
Plugin 'ekalinin/dockerfile.vim'
Plugin 'ingydotnet/yaml-vim'
Plugin 'mattn/emmet-vim'
Plugin 'jwalton512/vim-blade'

" vim-scripts repos
Plugin 'L9'
Plugin 'tComment'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" }}}

" General {{{
" map : to ; for qwerty
noremap ; :

set encoding=utf8
set laststatus=2        " Always show the statusline
set nocompatible        " the future is now, use vim defaults instead of vi ones

syntax enable 		      " Enable syntax highlighting
filetype on             " /!\ doesn't play well with compatible mode
filetype plugin on      " trigger file type specific plugins
filetype indent on      " indent based on file type syntax

set clipboard^=unnamed,unnamedplus   " Yank everything to the system clipboard

set history=1000        " keep 1000 lines of command line history
set undolevels=200      " Undo history
set ttyfast             " Yes, we have a fast terminal
set title               " change the terminal title
set lazyredraw          " do not redraw when executing macros
set report=0            " always report changes
nnoremap Q <Nop>        " we don't do ex mode

" }}}

" UI Layout {{{
set cmdheight=1         " height of the command line
set number              " show line numbers
set hidden
set ruler               " show the cursor position all the time
set showcmd             " show command in bottom bar
set scrolloff=1         " Always show at least one line above/below the cursor.
set nocursorline        " highlight current line
set wildmenu
" }}}

" {{{ Editing

set nowrap                      " don't wrap lines
set nojoinspaces                " insert only one space after '.', '?', '!' when joining lines
set showmatch                   " briefly jumps the cursor to the matching brace on insert
set matchtime=4                 " blink matching braces for 0.4s
set backspace=indent,eol,start  " allow backspacing over everything
if !has('nvim')
  fixdel
endif

set tabstop=2
set softtabstop=2
set shiftwidth=2                " indent with 2 spaces
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set expandtab
set wrap                        " set linewrap

function! Tab4Losers()
  set softtabstop=4
  set shiftwidth=4
  set tabstop=4
endfunction

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
" }}}

" Better line joins
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j
endif

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
" autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

" == Silver Searcher ===========================

" Ag
" brew install the_silver_searcher
" pacman -S the_silver_searcher
" apt-get install silversearcher-ag
let g:ackprg = 'ag --nogroup --nocolor --column --ignore="*.map" --ignore="*.min.js" --ignore node_modules'

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
endif

" == Completion ==================================

set completeopt=longest,menuone,preview             " better completion
set wildmenu                                        " enable ctrl-n and ctrl-p to scroll thru matches
set wildmode=longest:full,list:longest
set wildignore=*.o,*.obj,*~                         " stuff to ignore when tab completing
set wildignore+=*node_modules*
set wildignore+=*vim/backups*
set wildignore+=.git,.yarn                          " ignore the .git directory
set wildignore+=*.DS_Store                          " ignore Mac finder/spotlight crap
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.DS_Store,*.min.css,*.min.js,&.map

if exists("&wildignorecase")
  set wildignorecase
endif

" == Color + font ===================================

set ffs=unix,mac,dos	  " Support all three, in this order

" == Git/SVN Errors =====================================

match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" == Filetypes =======================================

au BufRead,BufNewFile *.module,*.inc,*.install    set filetype=php
au BufRead,BufNewFile *.less,*.scss               set filetype=css
" au BufRead,BufNewFile *.json                      set filetype=javascript
au BufRead,BufNewFile *.handlebars,*.hbs          set filetype=handlebars
au BufRead,BufNewFile *.tmpl,*.vue                set filetype=html
au BufRead,BufNewFile *.go                        set filetype=go
au BufRead,BufNewFile *.ru,*.rb                   set filetype=ruby
au BufNewFile,BufRead Fastfile,Appfile,Snapfile,Scanfile,Gymfile,Matchfile,Deliverfile set filetype=ruby

" Haskell
" autocmd FileType haskell                          setlocal expandtab shiftwidth=2 softtabstop=2
" au Bufenter *.hs,*.lhs compiler ghc
" " Extra syntax highlighting
" au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,.caprc,.irbrc,irb_tempfile*} set ft=ruby
" " Spell check certain filetypes (eg Markdown)
" autocmd BufRead,BufNewFile *.md,*.txt             setlocal spell

" Searching {{{
set hlsearch                " Highlight search things
set incsearch               " Make search act like search in modern browsers
set ignorecase              " Case insensitive matching...
set smartcase               " ... unless they contain at least one capital letter
" }}}

" Files/Backup {{{
set nobackup                " do not keep a backup file, use versions instead
set nowb
set noswapfile
" }}}

" Visualbell {{{
set visualbell              " shut up
set noerrorbells            " shut up
set mousehide               " hide mouse pointer when typing
" }}}

" Supertab {{{
let g:SuperTabDefaultCompletionType = "<c-n>"
" }}}
"
" Easy Align {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

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
if !has('nvim')
  set ttymouse=xterm2
endif

" == Airline =========================

set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline) "
let g:airline_powerline_fonts=1
set ttimeoutlen=50

" == Source after saving ================

" Keyboard {{{
let mapleader = ","

" Save
nnoremap <leader>w :w<CR>
nnoremap <C-s> :w<CR>

" Show/hide hidden characters
nmap <leader>l :set list!<cr>

" Clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

" Line Shortcuts {{{
nnoremap j gj
nnoremap k gk
nnoremap gV `[v`]
" }}}

command! KillWhitespace :call StripTrailingWhitespaces()<CR>
function! StripTrailingWhitespaces()
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
  :%s/\\\\\//g
endf

" Sudo to write
cmap w!! w !sudo tee % >/dev/null
command! -nargs=0 Sw w !sudo tee % > /dev/null

if has("gui_running") " Fuck you, help key, seriously
  set fuoptions=maxvert,maxhorz
  noremap  <F1> :set invfullscreen<CR>
  inoremap <F1> <ESC>:set invfullscreen<CR>
endif

" switch between last two files
nnoremap <leader><Tab> <c-^>

" move to the position where the last change was made
noremap gI `.

" split line and preserve cursor position
nnoremap S mzi<CR><ESC>`z

" escape insert mode
inoremap jj <ESC>

" == Paste mode ===============================

nnoremap <F2> :set invpaste paste?<CR> " Enable F2 key for toggling pastemode
imap <F2> <C-O><F2>
set pastetoggle=<F2>

" == HTML ===============================

:vmap <leader><leader>b <S-S><strong>
:vmap <leader><leader>i <S-S><em>

" convert list of lines to <li>
map <leader><leader>l :s/\s\+$//e<CR>:'<,'>s/^/<li>/g<CR>:'<,'>s/$/<\/li>/g<CR>:nohl<CR>

" == Nerdtree ===============================

nmap <silent> <c-n> :NERDTreeToggle \| :silent NERDTreeMirror<CR>

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" set autochdir
let NERDTreeChDirMode = 1

" close Nerdtree when only nerdtree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" == fzf ===================================

nmap <C-p> :Files<CR>
" nmap <C-t> :Tags<CR>

" == Emmet (previously Zencoding) ==========

" Emmet {{{
let g:use_emmet_complete_tag = 1
let g:user_emmet_leader_key = '<c-e>'
" }}}

" JSX
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}

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

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_fmt_command = "goimports"

" == VIM JSX =======================================================

let g:jsx_ext_required = 0

" == Snippets ======================================================

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsListSnippets="<c-tab>"

if has('nvim')
  let g:UltiSnipsUsePythonVersion = 2
else
  let g:UltiSnipsUsePythonVersion = 3
endif

" Do not interfere with vim mapping
inoremap <c-x><c-k> <c-x><c-k>

" == Highlight =========================
" Highlight words to avoid in production

" highlight TechWordsToAvoid ctermbg=red ctermfg=white
" match TechWordsToAvoid /\cconsole\|var_dump\|print_r\|alert\|console/
" autocmd BufWinEnter * match TechWordsToAvoid /\cconsole\|var_dump\|print_r\|alert\|console/
" autocmd InsertEnter * match TechWordsToAvoid /\cconsole\|var_dump\|print_r\|alert\|console/
" autocmd InsertLeave * match TechWordsToAvoid /\cconsole\|var_dump\|print_r\|alert\|console/
" autocmd BufWinLeave * call clearmatches()

" ALE {{{
autocmd FileType elixir nnoremap <c-]> :ALEGoToDefinition<cr>

let g:ale_completion_enabled = 0
let g:ale_php_phpcs_standard = "--tab-width=2"

" Disable linting in elixir so iex works https://github.com/elixir-editors/vim-elixir/issues/412
let g:ale_linters = {}
let g:ale_linters.elixir = []

let g:ale_fixers = {}
let g:ale_fixers.elixir = ['mix_format']
let g:ale_fixers.php = ['prettier']
" }}}

" == Javascript =============================

let g:javascript_plugin_flow = 1

" == Prettier =========================

" when running at every change you may want to disable quickfix
let g:prettier#quickfix_enabled = 0
let g:prettier#config#tab_width = 2

let g:prettier#autoformat = 0
let g:prettier#config#semi = 'false'
let g:prettier#config#trailing_comma = 'es5'
let g:prettier#config#parser = 'babylon'

autocmd BufWritePre *.js,*.json,*.css,*.scss,*.less,*.graphql Prettier
autocmd BufWritePre *.md Prettier
" let ftPHPToIgnore = ['blade.php']
" autocmd BufWritePre * if index(ftToIgnore, &ft) < 0 | Prettier
" autocmd BufWritePre *.php Prettier
autocmd FileType php let b:prettier_ft_default_args = { 'parser': 'php' }

" no save all, to prevent prettier errors
noremap :wq<cr> <nop>
noremap :x<cr> <nop>
nnoremap :wq<cr> <nop>
nnoremap :x<cr> <nop>
map :wq<cr> <nop>
map :x<cr> <nop>

" == Elixir format ====================

let g:mix_format_on_save = 1

" == vim test ========================================================

if has('nvim')
  let test#strategy = "neovim"
  " escape insert mode in terminal easier
  tmap <C-o> <C-\><C-n>
endif

let test#elixir#exunit#executable = "source .env.test && mix test"

nnoremap <leader>ts :TestSuite<CR> " test all
nnoremap <leader>tf :TestFile<CR>  " test single

" == git (fugitive) ==================================================

nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gl :Gpull<CR>

" if exists('$TMUX')
"   " Colors in tmux
"   let &t_8f = "<Esc>[38;2;%lu;%lu;%lum"
"   let &t_8b = "<Esc>[48;2;%lu;%lu;%lum"
" endif
" set termguicolors

" == User defined =====================

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
