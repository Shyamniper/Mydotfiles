
"""Nvim config file"""
""""""""""""""""""""""
" Save this file to ~/.config/nvim/init.vim

if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Fixes weird character problem in some devel versions neovim under tmux sesssion. This might go away in future.
set guicursor=
 autocmd BufEnter * :syntax sync fromstart

" Preferred default settings
set nowrap
" start R with F2 key
" map <F2> <Plug>RStart
" imap <F2> <Plug>RStart
" vmap <F2> <Plug>RStart
" R version can be specified like this:
" Shortcut for R's assignment operator: 0 turns it off; 1 assigns underscore; 2 assigns two underscores
let R_assign = 2

" Ensures usage of your own ~/.tmux.conf file
let R_notmuxconf = 1

" Shows function arguments in a separate viewport during omni completion with Ctrl-x Ctrl-o:w
let R_show_args = 1

" Use Ctrl-Space to do omnicompletion
inoremap <C-Space> <C-x><C-o>

" Remove white background of status line at bottom of nvim viewport (default is 2)
set laststatus=1

let R_in_buffer = 1
"let R_tmux_split = 1
"let R_applescript = 0
"let R_tmux_close = 0

" The following provides a zoom functionality, similar to Tmux's Ctrl-a z, by pressing 'gz' in normal mode.
function ZoomWindow()
	let cpos = getpos(".")
	tabnew %
	redraw
	call cursor(cpos[1], cpos[2])
	normal! zz
endfunction
nmap gz :call ZoomWindow()<CR>

"""""""""""""""""""""
"""NERDTree Plugin"""
"""""""""""""""""""""
" Installation
"       - Download NERDTree plugin from here
"         http://www.vim.org/scripts/script.php?script_id=1658
"       - unzip nerdtree.zip -d ~/.vim
" Usage
"   - '?' opens quick help
"   - 'zz' opens and 'q' closes NERDTree ('zz 'requires setting below)
"       - 't' opens file in new tab
"       - 'T' opens file in new tab silently
"   - 'gt' and 'gT' switch between tabs
"       - 'm' opens menu mode for creating/deleting files, 'Ctrl-c' to exit out of this mode
"
" Settings
" Opens NERDTree with custom shortcut, here 'zz'
let mapleader = "z"
nmap <leader>z :NERDTreeToggle<cr>

" Instruct NERDTree to always opens in the current folder
"set autochdir
"let NERDTreeChDirMode=2
"nnoremap <leader>n :NERDTree .<CR>

" Optional to show special NERDTree browser characters properly (e.g. on remote linux system)
let g:NERDTreeDirArrows=0

" Show bookmarks by default
let NERDTreeShowBookmarks=1
"""""""""""""""""""""""
let g:ale_completion_enabled = 1

call plug#begin('~/.vim/plugged')
Plug 'vundlevim/vundle.vim'
Plug 'powerline/powerline'
Plug 'jalvesaq/Nvim-R'
Plug 'gaalcaras/ncm-R'
Plug 'junegunn/seoul256.vim'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-syntax'
Plug 'Shougo/neco-syntax'
Plug 'machakann/vim-highlightedyank'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
Plug 'zchee/deoplete-jedi'
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'sbdchd/neoformat'
Plug 'neomake/neomake'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'yuki-ycino/ncm2-dictionary'
Plug 'w0rp/ale'
Plug 'chrisbra/csv.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'rizzatti/dash.vim'
Plug 'vim-syntastic/syntastic'
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
let g:strip_whitespace_on_save = 1
" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1
" Enable trimmming of trailing whitespacelet g:neoformat_basic_format_trim = 1
" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" wrap existing omnifunc
" Note that omnifunc does not run in background and may probably block the
" editor. If you don't want to be blocked by omnifunc too often, you could
" add 180ms delay before the omni wrapper:
"'on_complet': ['ncm2#on_complete#delay', 180, \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],

au User Ncm2Plugin call ncm2#register_source({
			\ 'name' : 'css',
			\ 'priority': 9,
			\'subscope_enable': 1,
			\ 'scope': ['css','scss'],
			\ 'mark': 'css',
			\ 'word_pattern': '[\w\-]+',
			\ 'complete_pattern': ':\s*',
			\ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
			\ })


let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {'R': ['lintr']}
let g:jedi#completions_enabled = 0
call plug#end()

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>
" Format on save, if desired
augroup fmt
	"   autocmd!
	autocmd BufWritePre * undojoin | Neoformat
augroup END
" Sample configuration for dictionary source with multiple
" dictionary files.
"setlocal dictionary+=/usr/share/hunspells/en_US.dic
" Remove this if you'd like to use fuzzy search
call deoplete#custom#source(
			\ 'dictionary', 'matchers', ['matcher_head'])
" If dictionary is already sorted, no need to sort it again.
call deoplete#custom#source(
			\ 'dictionary', 'sorters', [])
" Do not complete too short words
call deoplete#custom#source(
			\ 'dictionary', 'min_pattern_length', 4)
" remapping the basic :: send line
nmap , <Plug>RDSendLine
" remapping selection :: send multiple lines
vmap , <Plug>RDSendSelection
" remapping selection :: send multiple lines + echo lines
vmap ,e <Plug>RESendSelection
" remap search key
nmap <silent> <leader>d <Plug>DashSearch<CR>
" settings :: Nvim-R plugin

" R output is highlighted with current colorscheme
let g:rout_follow_colorscheme = 1

" R commands in R output are highlightedlet g:Rout_more_colors = 1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:syntastic_enable_r_lintr_checker = 1
"let g:syntastic_r_checkers = 1
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
""""""""""""""
call vundle#begin()
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'tpope/vim-fugitive'
Plugin 'christoomey/vim-tmux-navigator'
call vundle#end()
let g:clipboard = {
          \   'xsel': 'myClipboard',
	  \   'copy': {
          \      '+': 'tmux load-buffer -',
          \      '*': 'tmux load-buffer -',
          \   },
			\   'paste': {
          \      '+': 'tmux save-buffer -',
          \      '*': 'tmux save-buffer -',
          \   },
          \   'cache_enabled': 1,
          \ }
let R_app = "radian"
let R_cmd = "R"
let R_hl_term = 0
let R_args = []  " if you had set any
let R_bracketed_paste = 1
let g:fzf_layout = {'left': '30%'}
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
