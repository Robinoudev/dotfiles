let mapleader="\<Space>"

" if has('termguicolors')
"     set termguicolors
" endif
" set number                            " Line numbers
" set relativenumber                    " Numbers relative to current line
set hidden                            " Make it possible to hide unsaved buffers
set shiftwidth=4
set tabstop=4                         " A tab counts for 4 spaces
set expandtab                         " Convert tabs to spaces
set autoindent                        " copy indent when starting a new line from previous line
set splitbelow splitright             " Split new files to the right and under current buffer
set nowrap                            " Don't wrap lines that exceed the window view
" set cursorline                        " Highlight the line of the cursor
set scrolloff=6                       " Minimal no. of screen lines to keep above or
                                      " under cursor
set sidescroll=0                      " sidescroll in jumps because terminals are slow
set sidescrolloff=3                   " same as scrolloff, but for columns
set textwidth=80                      " maximum width of text in insert mode for comments
" set colorcolumn=+1                    " display a visible color column at the end of the textwidth

if exists('$SUDO_USER')
    set nobackup                      " don't create root-owned backup files
    set nowritebackup                 " don't create root-owned backup files
    set noswapfile                    " don't create root-owned swap files
    set noundofile                    " don't create root-owned undo files
else
    set backupdir=~/.vim/tmp/backup   " keep backup files out of the way
    set backupdir+=.
    set directory=~/.vim/tmp/swap//   " keep swap files out of the way
    set directory+=.
    set undofile                      " keep track of changes and undos so vim doesn't forget
    set undodir=~/.vim/tmp/undodir
    set undodir+=.
endif

if has('viminfo')
    if exists('$SUDO_USER')
        set viminfo=                  " don't create root-owned viminfo file
    else
        if isdirectory('~/local/.vim/tmp')
            set viminfo+=n~/local/.vim/tmp/viminfo
        else
            set viminfo+=n~/.vim/tmp/viminfo
        endif
    endif
endif

set updatetime=2000                   " no. of ms of inactivity it takes to update swap
                                      " or execute `CursorHold` autocommand
set path+=**                          " extend path into all subdirectories

set shortmess+=c                      " remove messages from ins-completion-menu
set shortmess+=A                      " remove swap file messages
set shortmess+=I                      " remove intro screen
set shortmess+=O                      " file-read message overwrites previous
set shortmess+=T                      " truncate non-file messages in middle
set shortmess+=W                      " don't echo "[w]"/"[written]" when writing
set shortmess+=a                      " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
set shortmess+=o                      " overwrite file-written messages
set shortmess+=t                      " truncate file messages at start

set ignorecase                        " ignore case of normal letters
set smartcase                         " only ignore the above when pattern has lower case letters only
set incsearch                         " when typing a search, show where the pattern matches
set undofile                          " keep track of changes and undos so vim doesn't forget
set undodir=~/.vim/undodir
set noerrorbells                      " no error bells when hitting esc in normal mode etc.

set list                              " show all characters defined in `listchars`
set listchars=nbsp:⦸                  " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
set listchars+=tab:▷┅                 " WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
                                      " + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
set listchars+=extends:»              " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:«             " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:•                " BULLET (U+2022, UTF-8: E2 80 A2)
set modelines=5                       " scan this many lines looking for modeline
set nojoinspaces                      " don't autoinsert two spaces after '.', '?', '!' for join command

set wildmode=longest:full,full        " shell like autocomplete in command mode

set clipboard+=unnamedplus            " Add the system clipboard to vim
set laststatus=2                      " always show status line
set lazyredraw                        " don't bother updating screen during macro playback

set switchbuf=usetab                  " when switching to a buffer in another tab, jump to that tab

if has('wildignore')
  set wildignore+=*.o,*.rej           " patterns to ignore during file-navigation
endif

if has('nvim')
    set signcolumn=yes:1              " always show a signcolumn on the left
    set inccommand=split              " show preview of in preview window (eg. %s/../../g)

    set shada=!,'1000,<50,s10,h       " make vim remember histories of previous sessions

    set fillchars=eob:~               " indicate end of buffer with the `~` character
    set fillchars+=fold:·             " dotted line for folds
    set fillchars+=diff:∙             " show deleted lines in diff mode as a dot
    set fillchars+=vert:┃             " thicker vertical line for splits

    set pumblend=25                   " give the popup window transparency
else
    set signcolumn=yes
endif
