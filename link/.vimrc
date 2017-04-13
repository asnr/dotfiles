noremap n j
noremap e k
noremap i l
noremap u i
noremap U I
noremap s d
noremap <C-s> <C-d>
noremap f e
noremap l u
noremap L U
noremap <C-l> <C-u>
noremap p r
noremap P R
noremap <C-p> <C-r>
noremap <C-P> <C-R>
noremap ; p
noremap f e
noremap d g
noremap dd gg
noremap D G
noremap <C-D> <C-G>
noremap k n
noremap K N
noremap y o
noremap Y O
noremap <C-y> <C-o>
noremap <C-u> <C-i>
noremap j y
noremap o ;
noremap O :
noremap dt gf
noremap <C-W>i <C-W>l
noremap <C-W>n <C-W>j
noremap <C-W>e <C-W>k
noremap <C-W>y <C-W>o

inoremap <C-k> <C-n>
inoremap <C-p> <C-r>
inoremap <C-s> <C-d>
" Cannot map <C-;> because terminals cannot see the Ctrl+; combination.
" See http://vim.1045645.n5.nabble.com/Mapping-ctrl-ctrl-semicolon-td1193549.html
" Might be able to work around it:
"  http://stackoverflow.com/questions/23546025/how-can-i-map-ctrl-semicolon-to-add-a-semicolon-to-the-end-of-the-line
"
" inoremap <C-;> <C-p>

cnoremap <C-p> <C-r>
cnoremap <C-n> <C-j>
cnoremap <C-s> <C-d>

let mapleader=","
noremap ,a :CtrlP<CR>
noremap ,r :NERDTreeToggle<CR>

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" required for Vundle
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'joukevandermaas/vim-ember-hbs'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'

" All of your Vundle managed Plugins must be added before the following line
call vundle#end()            " required by Vundle
filetype plugin indent on    " required by Vundle

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Allow editing of a different file if current buffer has been modified
set hidden

" Map CtrlP to an out of the way combination so that it doesn't conflict with
" redo (<C-R>)
let g:ctrlp_map = '<C-\>'

" The default mapping of NERDTreeMapOpenExpl to 'e' stuffs up my Colemak-adjusted up navigation; remap it to where Colemak maps 'e'.
let NERDTreeMapActivateNode = 'y'
let NERDTreeMapOpenExpl = 'f'
let NERDTreeMapOpenSplit = 'u'
let NERDTreeShowHidden = 1

" Fix surround.vim to work with my Colemak bindings
let g:surround_no_mappings = 1
nmap sr  <Plug>Dsurround
nmap cr  <Plug>Csurround
nmap jr  <Plug>Ysurround
nmap jR  <Plug>YSurround
nmap jrr <Plug>Yssurround
nmap jRr <Plug>YSsurround
nmap jRR <Plug>YSsurround
xmap R   <Plug>VSurround
xmap dR  <Plug>VgSurround

" Fix mapping inside CtrlP's prompt
" We map some functions to nothing because their default mappings clobber our
" <c-n>, <c-e> maps
let g:ctrlp_prompt_mappings = {
  \ 'PrtClear()':           ['<c-l>'],
  \ 'PrtSelectMove("j")':   ['<c-n>', '<down>'],
  \ 'PrtSelectMove("k")':   ['<c-e>', '<up>'],
  \ 'PrtHistory(-1)':       [],
  \ 'PrtCurEnd()':          [],
  \ }
