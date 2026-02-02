" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim
set encoding=utf8
set guifont=JetBrainsMono\ Nerd\ Font\ 12
set termguicolors
set number
" show tab as 4 spaces width
set tabstop=4
" tab inserts 4 spaces
set shiftwidth=4
" ues spaces instead of tab
set expandtab
colorscheme catppuccin_mocha
let &t_ut=''
" See end of line characters
set list
" set trailing spaces character to 
set listchars+=trail:◦
" sets the end of line character to \ 
set listchars+=eol:\ 
syntax enable
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p 
" Close the tab if NERDTree is the only window remaning in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif


"asyncomplete tab completion remap
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,noselect,preview
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

au User asyncomplete_setup call asyncomplete#register_source(
\   asyncomplete#sources#ale#get_source_options({
\       'priority': 10,
\   })
\)

let g:ale_completion_autoimport = 1

" Hexokinase Patterns to match
let g:Hexokinase_optInPatterns = 'full_hex,triple_hex,rgb,rgba,hsl,hsla,colour_names'
" Hexokinase Highlighting
let g:Hexokinase_highlighters = ['backgroundfull']
let g:airline#extensions#tabline#enabled=1
" Set scripts to executable from shell if a shebang is present
" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim80/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" do not load defaults if ~/.vimrc is missing
"let skip_defaults_vim=1
