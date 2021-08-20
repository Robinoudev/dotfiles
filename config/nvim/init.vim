call plug#begin('~/.vim/plugged')
    " FZF
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'stsewd/fzf-checkout.vim'

    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-commentary'
    Plug 'justinmk/vim-dirvish'

    " Neovim Tree shitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground'

    " Colors
    Plug 'dracula/vim'
call plug#end()

filetype indent plugin on
syntax on
colorscheme dracula

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

augroup THE_PRIMEAGEN
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END
