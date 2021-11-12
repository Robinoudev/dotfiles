local scopes = {o = vim.o, b = vim.bo, w = vim.wo}


local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then
        scopes["o"][key] = value
    end
end


opt("w", "number", true)              -- Line numbers
opt("w", "relativenumber", true)      -- Numbers relative to current line
opt("o", "hidden", true)              -- Make it possible to hide unsaved buffers
opt("b", "shiftwidth", 2 )
opt("b", "tabstop", 2 )               -- A tab counts for 4 spaces
opt("b", "expandtab", true)           -- Convert tabs to spaces
opt("o", "autoindent", true)          -- copy indent when starting a new line from previous line
opt("o", "splitbelow", true)          -- Split new files under cursor
opt("o", "splitright", true)          -- Split new files to the right of cursor
opt("w", "wrap", false)               -- Don't wrap lines that exceed the window view
opt("o", "cursorline", false)         -- Highlight the line of the cursor
opt("o", "scrolloff", 6)              -- Minimal no. of screen lines to keep above or
                                      -- under cursor

opt("o", "sidescroll", 0)             -- sidescroll in jumps because terminals are slow
opt("o", "sidescrolloff", 3)          -- same as scrolloff, but for columns
opt("o", "textwidth", 80)             -- maximum width of text in insert mode for comments
-- opt("o", "colorcolumn", "+1")         -- display a visible color column at the end of the textwidth
opt("o", "updatetime", 1000)          -- no. of ms of inactivity it takes to update swap

local dir = os.getenv("HOME")
-- don't create root owned files
if os.getenv("SUDO_USER") or os.getenv("DOAS_USER") then
    opt("o", "backup", false)
    opt("o", "writebackup", false)
    opt("o", "swapfile", false)
    opt("o", "undofile", false)
else -- set correct dirs for files
    -- opt("o", "backupdir", backupdir)
    opt("o", "directory", dir .. "/.vim/tmp/swap//")
    opt("o", "undofile", true)
    opt("o", "undodir", dir .. "/.vim/tmp/undodir//")
end

opt("o", "path", scopes.o.path .. "**")           -- extend path into all subdirectories

local shortmess = scopes.o.shortmess
shortmess = shortmess .. "c"                   --  remove messages from ins-completion-menu
shortmess = shortmess .. "A"                   --  remove swap file messages
shortmess = shortmess .. "I"                   --  remove intro screen
shortmess = shortmess .. "O"                   --  file-read message overwrites previous
shortmess = shortmess .. "T"                   --  truncate non-file messages in middle
shortmess = shortmess .. "W"                   --  don't echo "[w]"/"[written]" when writing
shortmess = shortmess .. "a"                   --  use abbreviations in messages eg. `[RO]` instead of `[readonly]`
shortmess = shortmess .. "o"                   --  overwrite file-written messages
shortmess = shortmess .. "t"                   --  truncate file messages at start
opt("o", "shortmess", shortmess)

opt("o", "ignorecase", true)                   -- ignore case of normal letters
opt("o", "smartcase", true)                    -- only ignore the above when pattern has lower case letters only
opt("o", "incsearch", true)                    -- when typing a search, show where the pattern matches
opt("o", "errorbells", false)                 -- no error bells when hitting esc in normal mode etc.

opt("o", "list", true)                         -- show all characters defined in `listchars`
vim.cmd "set listchars=nbsp:⦸"                 -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
vim.cmd "set listchars+=tab:▷┅"                -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
                                               -- " + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
vim.cmd "set listchars+=extends:»"             -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
vim.cmd "set listchars+=precedes:«"            -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
vim.cmd "set listchars+=trail:•"               -- BULLET (U+2022, UTF-8: E2 80 A2)

opt("o", "modelines", 5)                       -- scan this many lines looking for modeline
opt("o", "joinspaces", false)                 -- don't autoinsert two spaces after '.', '?', '!' for join command

opt("o", "wildmode", "longest:full,full")


opt("o", "clipboard", "unnamedplus")           -- Add the system clipboard to vim
opt("o", "laststatus", 2)                      -- always show status line
opt("o", "lazyredraw", true)                   -- don't bother updating screen during macro playback

opt("o", "switchbuf", "usetab")                -- when switching to a buffer in another tab, jump to that tab
opt("o", "wildignore", "*.o,*.rej")            -- patterns to ignore during file-navigation
opt("w", "signcolumn", "yes:1")                -- always show a signcolumn on the left
opt("o", "inccommand", "split")                -- show preview of in preview window (eg. %s/../../g)

opt("o", "shada", "!,'1000,<50,s10,h")         --  make vim remember histories of previous sessions
opt("o", "fillchars", "eob:~,fold:·,diff:∙")
opt("o", "pumblend", 25)                       -- give the popup window transparency

opt("o", "termguicolors", true)
opt("o", "numberwidth", 2)
opt("o", "mouse", "a")
opt("o", "cmdheight", 1)

vim.cmd "set fillchars+=vert:│"

-- COLORSCHEME
vim.g.material_style = "deep ocean"
-- vim.cmd "colorscheme codesmell_dark"
vim.cmd "colorscheme material"
-- require('material').set()
-- vim.g.modus_moody_enable

local M = {}

function M.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand("%:t")) == 1
end

function M.has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end

return M
