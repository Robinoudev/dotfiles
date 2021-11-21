require'robin'

-------------------------------------------------------------------------------
-- Options {{{1 ---------------------------------------------------------------
-------------------------------------------------------------------------------

local vim = vim
local root = vim.env.USER == 'root'
local home = vim.env.HOME
local config = home .. "/.config/nvim"

vim.opt.number         = true                              -- line numbers
vim.opt.relativenumber = true                              -- numbers relative to current line
vim.opt.hidden         = true                              -- make it possible to hide unsaved buffers
vim.opt.shiftwidth     = 2
vim.opt.tabstop        = 2                                 -- a tab counts for 2 spaces
vim.opt.shiftround     = false                             -- don't always indent by multiple of shiftwidth
vim.opt.expandtab      = true                              -- convert tabs to spaces
vim.opt.autoindent     = true                              -- copy indent when starting a new line from previous line
vim.opt.splitbelow     = true                              -- split new files under cursor
vim.opt.splitright     = true                              -- split new files to the right of cursor
vim.opt.wrap           = false                             -- don't wrap lines that exceed the window view
vim.opt.cursorline     = false                             -- highlight the line of the cursor
vim.opt.scrolloff      = 3                                 -- minimal no. of screen lines to keep above or under cursor
vim.opt.sidescroll     = 0                                 -- sidescroll in jumps because terminals are slow
vim.opt.sidescrolloff  = 3                                 -- same as scrolloff, but for columns
vim.opt.textwidth      = 80                                -- maximum width of text in insert mode for comments
vim.opt.colorcolumn    = "+1"                              -- display a visible color column at the end of the textwidth
vim.opt.showbreak      = '↳ '                              -- DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
vim.opt.showcmd        = false                             -- don't show extra info at end of command line
vim.opt.smarttab       = true                              -- <tab>/<BS> indent/dedent in leading whitespace
vim.opt.ignorecase     = true                              -- ignore case of normal letters
vim.opt.smartcase      = true                              -- only ignore the above when pattern has lower case letters only
vim.opt.incsearch      = true                              -- when typing a search, show where the pattern matches
vim.opt.errorbells     = false                             -- no error bells when hitting esc in normal mode etc.
vim.opt.list           = true                              -- show all characters defined in `listchars`
vim.opt.modelines      = 5                                 -- scan this many lines looking for modeline
vim.opt.joinspaces     = false                             -- don't autoinsert two spaces after '.', '?', '!' for join command
vim.opt.wildmode       = "longest:full,full"
vim.opt.clipboard      = "unnamedplus"                     -- Add the system clipboard to vim
vim.opt.laststatus     = 2                                 -- always show status line
vim.opt.lazyredraw     = true                              -- don't bother updating screen during macro playback
vim.opt.switchbuf      = "usetab"                          -- when switching to a buffer in another tab, jump to that tab
vim.opt.signcolumn     = "yes:1"                           -- always show a signcolumn on the left
vim.opt.inccommand     = "split"                           -- show preview of in preview window (eg. %s/../../g)
vim.opt.pumblend       = 25                                -- give the popup window transparency
vim.opt.termguicolors  = true
vim.opt.numberwidth    = 2
vim.opt.mouse          = "a"
vim.opt.cmdheight      = 1
vim.opt.spellcapcheck  = ""                                -- don't check for capital letters at start of sentence
vim.opt.synmaxcol      = 200                               -- don't bother syntax highlighting long lines
vim.opt.formatoptions  = vim.opt.formatoptions + 'j'       -- remove comment leader when joining comment lines
vim.opt.formatoptions  = vim.opt.formatoptions + 'n'       -- smart auto-indenting inside numbered lists

vim.opt.directory      = config .. "/nvim/swap//"          -- keep swap files out of the way
vim.opt.directory      = vim.opt.directory + "."           -- fallback
vim.opt.backupdir      = config .. '/backup//'             -- keep backup files out of the way (ie. if 'backup' is ever set)
vim.opt.backupdir      = vim.opt.backupdir + '.'           -- fallback
vim.opt.backupskip     = vim.opt.backupskip + '*.re,*.rei' -- prevent bsb's watch mode from getting confused (if 'backup' is ever set)

if root then
  vim.opt.undofile = false -- don't create root-owned files
else
  vim.opt.undodir  = config .. '/undo//'   -- keep undo files out of the way
  vim.opt.undodir  = vim.opt.undodir + '.' -- fallback
  vim.opt.undofile = true                  -- actually use undo files
end


vim.opt.updatetime  = 2000                                  -- CursorHold interval
vim.opt.updatecount = 0                                     -- update swapfiles every 80 typed chars
vim.opt.viewdir     = config .. '/view'                     -- where to store files for :mkview
vim.opt.viewoptions = 'cursor,folds'                        -- save/restore just these (with `:{mk,load}view`)
vim.opt.virtualedit = 'block'                               -- allow cursor to move where there is no text in visual block mode
vim.opt.visualbell  = true                                  -- stop annoying beeping for non-error errors
vim.opt.whichwrap   = 'b,h,l,s,<,>,[,],~'                   -- allow <BS>/h/l/<Left>/<Right>/<Space>, ~ to cross line boundaries
vim.opt.wildcharm   = 26                                    -- ('<C-z>') substitute for 'wildchar' (<Tab>) in macros
vim.opt.wildignore  = vim.opt.wildignore + '*.o,*.rej,*.so' -- patterns to ignore during file-navigation
vim.opt.writebackup = false                                 -- don't write backup files
vim.opt.swapfile    = false                                 -- don't create swap files

vim.opt.shortmess     = vim.opt.shortmess + 'A' -- ignore annoying swapfile messages
vim.opt.shortmess     = vim.opt.shortmess + 'I' -- no splash screen
vim.opt.shortmess     = vim.opt.shortmess + 'O' -- file-read message overwrites previous
vim.opt.shortmess     = vim.opt.shortmess + 'T' -- truncate non-file messages in middle
vim.opt.shortmess     = vim.opt.shortmess + 'W' -- don't echo "[w]"/"[written]" when writing
vim.opt.shortmess     = vim.opt.shortmess + 'a' -- use abbreviations in messages eg. `[RO]` instead of `[readonly]`
vim.opt.shortmess     = vim.opt.shortmess + 'c' -- completion messages
vim.opt.shortmess     = vim.opt.shortmess + 'o' -- overwrite file-written messages
vim.opt.shortmess     = vim.opt.shortmess + 't' -- truncate file messages at start



if root then
  vim.opt.shada     = "" -- Don't create root-owned files.
  vim.opt.shadafile = "NONE"
else
  -- Defaults:
  --   Neovim: !,'100,<50,s10,h
  --
  -- - ! save/restore global variables (only all-uppercase variables)
  -- - '100 save/restore marks from last 100 files
  -- - <50 save/restore 50 lines from each register
  -- - s10 max item size 10KB
  -- - h do not save/restore 'hlsearch' setting
  --
  -- Our overrides:
  -- - '0 store marks for 0 files
  -- - <0 don't save registers
  -- - f0 don't store file marks
  -- - n: store in ~/.config/nvim/
  --
  vim.opt.shada = "'0,<0,f0,n" .. config .. "shada"
end
vim.opt.listchars      = {
  nbsp                 = '⦸',                              -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
  extends              = '»',                              -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
  precedes             = '«',                              -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
  tab                  = '▷⋯',                             -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + MIDLINE HORIZONTAL ELLIPSIS (U+22EF, UTF-8: E2 8B AF)
  trail                = '•',                              -- BULLET (U+2022, UTF-8: E2 80 A2)
}
vim.opt.fillchars      = {
  diff                 = '∙',                              -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
  eob                  = ' ',                              -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
  fold                 = '·',                              -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
  vert                 = '┃',                              -- BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
}

-------------------------------------------------------------------------------
-- Globals {{{1 ---------------------------------------------------------------
-------------------------------------------------------------------------------

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- COLORSCHEME
-- vim.g.material_style = "deep ocean"
-- vim.g.tokyonight_style = "night"
-- vim.cmd "colorscheme codesmell_dark"
vim.cmd "colorscheme base16-default-dark"
-- vim.cmd[[colorscheme tokyonight]]
-- require('material').set()
-- vim.g.modus_moody_enable


-- TODO: Refactor this to lua code
vim.cmd [[
filetype indent plugin on
syntax on

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

" JUST WRITE
com! W w

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup TRIM_WHITESPACE
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END
]]

-- vim: foldmethod=marker

