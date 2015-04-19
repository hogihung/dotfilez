" Author:       John F. Hogarty
" Email:        hogihung@gmail.com
" --------------------------------------
set nocompatible		" be iMproved, required
filetype off  			" required

" set the runtime path to include Vundle and initialize
" url: https://github.com/gmarik/Vundle.vim
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call bundle #begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
" Plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-coffee-script'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-ruby/vim-ruby'
Plugin 't9md/vim-ruby-xmpfilter'
Plugin 'tomtom/tlib_vim.git'           " required for snipmate
Plugin 'marcweber/vim-addon-mw-utils'  " required for snipmate
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tmhedberg/matchit'
Plugin 'jgdavey/tslime.vim'
Plugin 'jgdavey/vim-railscasts'
Plugin 'altercation/vim-colors-solarized'
" Plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
Plugin 'yegappan/greplace'

" All of your Plugins must be added before the following line
call vundle#end()		" required
filetype plugin indent on	" required

" Set basic setup
syntax on
set shell=zsh
set number
set t_Co=256  " Set terminal colors to 256
set listchars=tab:▸\ ,eol:¬  " Use same symbols as TextMate for tabstops and EOLs

" Change leader, which defaults as backslash, to the comma key
let mapleader = ","

" Swap the less used semi-colon for colon
nnoremap ; :

" Create mapping to shortcut using :%:h
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Adjusting tab spacing, use softtabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Configure color theme
let g:solarized_termcolors=256
syntax enable
set background=dark 
colorscheme solarized

" Add some column when exceeding the 80th column
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)
" use below line instead of the above for a solid column
"set colorcolumn=81

" Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" Shortcut for rapid toggle 'set list'
nmap <leader>sl :set list!<CR>
" Disable vim auto-paste (corrects too much identing)
map <leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
" Shortcut for identing entire page
map <leader>i mmgg=G`m<CR>

" Search configuration
set incsearch     " Highlight while searching
set hlsearch      " Highlight all matches after entering search pattern
" Toggle highlighting off
nmap <leader>h :nohlsearch<cr>
set ignorecase    " Case insensitive pattern matching
set smartcase     " Overrides ignorecase if pattern contains upcase

" Map TextMate/Sublime commands for indentation
" (Command key seems to only work in OS X)
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

" Map Vim Window navigation
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" Map keys to support executing ruby code inside vim
nmap <buffer> <F4> <Plug>(xmpfilter-mark)
xmap <buffer> <F4> <Plug>(xmpfilter-mark)
imap <buffer> <F4> <Plug>(xmpfilter-mark)

nmap <buffer> <F5> <Plug>(xmpfilter-run)
xmap <buffer> <F5> <Plug>(xmpfilter-run)
imap <buffer> <F5> <Plug>(xmpfilter-run)

" Support of Silver Searcher
" url: https://github.com/ggreer/the_silver_searcher
let g:ackprg = 'ag --nogroup --nocolor --column'

" Support sending rspec to tmux (thoughtbot)
" http://robots.thoughtbot.com/running-specs-from-vim-sent-to-tmux-via-tslime
let g:rspec_command = 'call Send_to_Tmux("rspec {spec}\n")'

" vim-rspec mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>


" Handle whitespace based on file type
if has("autocmd")
  " enable file type detection
  filetype on

  " Languages which are picky about tabs vs. spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  " Customization based on house-style (arbitrary)
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd FileType perl setlocal ts=4 sts=4 sw=4 noexpandtab

  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss setfiletype xml

  " Remove trailing whitespace automatically while a file
  " is saved, for the defined file extensions:
  autocmd BufWritePre *.txt,*.rb,*.erb :call <SID>StripTrailingWhitespaces()
endif


" PUT FUNCTIONS FROM HERE DOWN
" ----------------------------
" Set tabstop, softabstop and shiftwidth to the same value
" To use, type:  :Stab
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' shofttabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon 'noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

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

