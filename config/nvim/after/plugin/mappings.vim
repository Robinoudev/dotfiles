" NORMAL MODE {{{
nnoremap <silent><leader>bd :bd<CR>
nnoremap <leader>pv :Vex <bar> :vertical resize 30
nnoremap <leader>q :q<CR>

" clear search highlight with escape
nnoremap <silent> <esc> :noh<cr>

" Turn on 'verymagic' mode when searching
nnoremap / /\v
nnoremap ? ?\v

" Folds and splits
nnoremap <C-h> <C-w><C-h>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>

" toggle folds w/ shift tab
nnoremap , za

" Yank from cursor to end of line
nnoremap Y y$

" FZF
nnoremap <C-p> :Telescope find_files<CR>
nnoremap <leader><leader> :Telescope find_files<CR>
nnoremap <leader>pf :Files<CR>
nnoremap <leader>ps :Telescope live_grep<CR>
nnoremap <leader>pw :Telescope grep_string<CR>
nnoremap <leader>pb :Telescope buffers<CR>
nnoremap <leader>pt :Rg TODO\(robin\)<CR>
nnoremap <leader>ca :Telescope lsp_code_actions<CR>
nnoremap <leader>cd :Telescope lsp_definitions<CR>
nnoremap <leader>ht :Telescope help_tags<CR>

" Git
nmap <silent><leader>gs :G<CR>
nmap <leader>gp :Git push<Space>
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nmap <leader>gc :GBranches<CR>
nmap <leader>gfa :Git fetch --all --prune<CR>
" }}}

" VISUAL MODE {{{
" Delete selected text without overwriting register
vnoremap X "_d

" paste over selected text without overwriting register
vnoremap <leader>p "_dP

" Indent selected lines and keep selection
vmap < <gv
vmap > >gv

" Also turn on 'verymagic' mode on visual select search
vnoremap / /\v
vnoremap ? ?\v
" }}}

" COMMAND MODE {{{
" Yank the current file to the system clipboard
cnoremap yf!! !echo % <bar> xclip -selection clipboard

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
" }}}
