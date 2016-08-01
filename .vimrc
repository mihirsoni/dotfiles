set nocompatible              " be iMproved, required
filetype off                  " required

"Syntax highlighting {{{
set t_Co=256
set background=dark
syntax on
colorscheme OceanicNext
" }}}
" Local directories {{{
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo
" }}}

set nu
set autoindent " Copy indent from last line when starting new line
set backspace=indent,eol,start
set cursorline " Highlight current line
set expandtab " Expand tabs to spaces
set gdefault " By default add g flag to search/replace. Add g to toggle
set hlsearch " Highlight searches
set ignorecase " Ignore case of searches
set incsearch " Highlight dynamically as pattern is typed
set laststatus=2 " Always show status line
set mouse=a " Enable mouse in all in all modes
set nostartofline " Don't reset cursor to start of line when moving around
set nowrap " Do not wrap lines
set shiftwidth=2 " The # of spaces for indenting
set showtabline=2 " Always show tab bar
set smartcase " Ignore 'ignorecase' if search patter contains uppercase characters
set softtabstop=2 " Tab key results in 2 spaces
set splitbelow " New window goes below
set title " Show the filename in the window titlebar
set undofile " Persistent Undo
set wildignore+=.DS_Store
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/bower_components/*,*/node_modules/*,*/dist/*,*/static/* "This will be ingore
set wildmenu " Hitting TAB in command mode will show possible completions above command line
set wildmode=list:longest " Complete only until point of ambiguity
set winminheight=0 " Allow splits to be reduced to a single line
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Strip trailing whitespace (,ss) {{{
function! StripWhitespace () " {{{
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction " }}}
noremap <leader>ss :call StripWhitespace ()<CR>
" }}}

" Fix page up and down {{{
map <PageUp> <C-U>
map <PageDown> <C-D>
imap <PageUp> <C-O><C-U>
imap <PageDown> <C-O><C-D>
" }}}

" Filetypes -------------------------------------------------------------

" C {{{
augroup filetype_c
  autocmd!

  " Highlight Custom C Types {{{
  autocmd BufRead,BufNewFile *.[ch] let fname = expand('<afile>:p:h') . '/types.vim'
  autocmd BufRead,BufNewFile *.[ch] if filereadable(fname)
  autocmd BufRead,BufNewFile *.[ch]   exe 'so ' . fname
  autocmd BufRead,BufNewFile *.[ch] endif
  " }}}
augroup END
" }}}

" Clojure {{{
augroup filetype_clojure
  autocmd!
  let g:vimclojure#ParenRainbow = 1 " Enable rainbow parens
  let g:vimclojure#DynamicHighlighting = 1 " Dynamic highlighting
  let g:vimclojure#FuzzyIndent = 1 " Names beginning in 'def' or 'with' to be indented as if they were included in the 'lispwords' option
augroup END
" }}}

" Coffee {{{
augroup filetype_coffee
  autocmd!
  au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
augroup END
" }}}

" Fish {{{
augroup filetype_fish
  autocmd!
  au BufRead,BufNewFile *.fish set ft=fish
augroup END
" }}}

" Handlebars {{{
augroup filetype_hbs
  autocmd!
  au BufRead,BufNewFile *.hbs,*.handlebars,*.hbs.erb,*.handlebars.erb setl ft=mustache syntax=mustache
augroup END
" }}}

" Jade {{{
augroup filetype_jade
  autocmd!
  au BufRead,BufNewFile *.jade set ft=jade syntax=jade
augroup END
" }}}

" JavaScript {{{
augroup filetype_javascript
  autocmd!
  let g:javascript_conceal = 1
augroup END
" }}}

" JSON {{{
augroup filetype_json
  autocmd!
  au BufRead,BufNewFile *.json set ft=json syntax=javascript
augroup END
" }}}

" Markdown {{{
augroup filetype_markdown
  autocmd!
  let g:markdown_fenced_languages = ['ruby', 'html', 'javascript', 'css', 'erb=eruby.html', 'bash=sh']
augroup END
" }}}

" Nu {{{
augroup filetype_nu
  autocmd!
  au BufNewFile,BufRead *.nu,*.nujson,Nukefile setf nu
augroup END
" }}}

" Ruby {{{
augroup filetype_ruby
  autocmd!

  au BufRead,BufNewFile Rakefile,Capfile,Gemfile,.autotest,.irbrc,*.treetop,*.tt set ft=ruby syntax=ruby

  " Ruby.vim {{{
  let ruby_operators = 1
  let ruby_space_errors = 1
  let ruby_fold = 1
  " }}}
augroup END
" }}}

" }}}
" XML {{{
augroup filetype_xml
  autocmd!
  au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"
augroup END
" }}}

" ZSH {{{
augroup filetype_zsh
  autocmd!
  au BufRead,BufNewFile .zsh_rc,.functions,.commonrc set ft=zsh
augroup END
" }}}

" Plugin Configuration -------------------------------------------------------------

" Airline.vim {{{
augroup airline_config
  autocmd!
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#syntastic#enabled = 1
  let g:airline#extensions#tabline#buffer_nr_format = '%s '
  let g:airline#extensions#tabline#buffer_nr_show = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#fnamemod = ':t'
augroup END
" }}}

" CtrlP.vim {{{
augroup ctrlp_config
  autocmd!
  let g:ctrlp_clear_cache_on_exit = 0 " Do not clear filenames cache, to improve CtrlP startup
  let g:ctrlp_lazy_update = 350 " Set delay to prevent extra search
  let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' } " Use python fuzzy matcher for better performance
  let g:ctrlp_match_window_bottom = 0 " Show at top of window
  let g:ctrlp_max_files = 0 " Set no file limit, we are building a big project
  let g:ctrlp_switch_buffer = 'Et' " Jump to tab AND buffer if already open
  let g:ctrlp_open_new_file = 'r' " Open newly created files in the current window
  let g:ctrlp_open_multiple_files = 'ij' " Open multiple files in hidden buffers, and jump to the first one
augroup END
" }}}
" EasyAlign.vim {{{
augroup easy_align_config
  autocmd!
  vmap <Enter> <Plug>(EasyAlign) " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
  nmap <Leader>a <Plug>(EasyAlign) " Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
augroup END
" }}}

" Notes.vim {{{
augroup notes_config
  autocmd!
  let g:notes_directories = ['~/User/mihir/Notes']
augroup END
" }}}

" RainbowParenthesis.vim {{{
augroup rainbow_parenthesis_config
  autocmd!
  nnoremap <leader>rp :RainbowParenthesesToggle<CR>
augroup END
" }}}

" Syntastic.vim {{{
augroup syntastic_config

  highlight link SyntasticErrorSign SignColumn
  highlight link SyntasticWarningSign SignColumn
  highlight link SyntasticStyleErrorSign SignColumn
  highlight link SyntasticStyleWarningSign SignColumn
  let g:syntastic_check_on_wq = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_error_symbol = '✗'
  let g:syntastic_warning_symbol = '⚠'
  let g:syntastic_javascript_checkers = []
  autocmd FileType javascript let b:syntastic_checkers = findfile('.eslintrc', '.;') !=# '' ? ['eslint'] : []
augroup END
" }}}

" JSX.vim {{{
augroup jsx_config
  autocmd!
  let g:jsx_ext_required = 0
augroup END
" }}}

call plug#begin('~/.vim/plugged')
Plug 'ap/vim-css-color'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'junegunn/vim-emoji'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/goyo.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'mxw/vim-jsx'
Plug 'mhartington/oceanic-next'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'othree/yajs.vim'
Plug 'rking/ag.vim'
Plug 'tpope/vim-fugitive' "Manage Git commands from VIM
Plug 'tpope/vim-markdown',     { 'for': 'markdown' }
Plug 'tpope/vim-repeat'
Plug 'scrooloose/nerdtree' "This will install tree for vim
Plug 'scrooloose/syntastic' "This will enable sysnstaic for JS eslint
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/jade.vim',   { 'for': 'jade' }
Plug 'vim-scripts/SyntaxComplete'
Plug 'wavded/vim-stylus',      { 'for': 'stylus' }
Plug 'Xuyuanp/nerdtree-git-plugin' " This will enable highlight of GIT within nerd tree
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
call plug#end()


