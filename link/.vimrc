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
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'asnr/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'joukevandermaas/vim-ember-hbs'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-ruby/vim-ruby'
Plugin 'scrooloose/syntastic'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'python/black'

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

" Allow editing of a different file if current buffer has been modified
set hidden

if executable('ag')
  " Use Ag over Grep. --hidden includes dotfiles in searches, which forces us
  " to --ignore .git/
  set grepprg=ag\ --nogroup\ --nocolor\ --hidden\ --ignore\ .git/
endif

" Turn on vim-colors-solarized. Taken from the vim-colors-solarized README.md.
" Next two lines fix weird colour bug in terminals, see
"   https://github.com/altercation/vim-colors-solarized/issues/138#issuecomment-408307083
let g:solarized_termcolors=256
set t_Co=256
syntax enable
set background=light
colorscheme solarized

" Set vim airline (status/tab line) theme to solarized
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

augroup XML
  autocmd!
  autocmd FileType xml setlocal foldmethod=indent foldlevelstart=999 foldminlines=0
augroup END

" Make trailing spaces visible, but not in insert mode, otherwise it gets
" distracting.
" TODO 'set listchars=tab:>\ ,trail:_' if no multibyte/utf-8
set listchars=tab:▸\ ,nbsp:␣
augroup dont_listchars_in_insert_mode
  autocmd!
  autocmd InsertEnter * set listchars=tab:▸\ ,nbsp:␣
  autocmd InsertLeave * set listchars=tab:▸\ ,nbsp:␣,trail:·
augroup END
set list

" TODO write function to remove trailing spaces, map to F2

" Added the line below to get rid of the delay between pressing ESC in
" commandline mode and returning to normal mode. I'm not entirely clear on all
" the ramifications of adding this line, I may have to tweak/remove it in the
" future. Taken from
"   https://www.johnhawthorn.com/2012/09/vi-escape-delays/
" which has explanation.
set timeoutlen=1000 ttimeoutlen=0

" Searches with '/' are case insensitive unless the search string has a
" capital letter.
set ignorecase
set smartcase

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=1200

set splitright  " open vertical splits on the right
set splitbelow  " open the horizontal split below

" Set reasonble indenting defaults
set tabstop=2 shiftwidth=2  " a tab is two spaces
set expandtab               " use spaces, not tabs

" Syntastic plugin settings. Copied from README
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive' }
let g:syntastic_ruby_checkers = ['rubocop', 'mri']

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Instruct NERDTree to display dot files
let NERDTreeShowHidden = 1

" NERDTree should not display files ending in ~ or .pyc
let NERDTreeIgnore = ['\~$[[file]]', '\.pyc$[[file]]']

" In the command line, substitute the current file's directory for '%h'.
" E.g. if editing ~/foo/bar.txt, %h will evaluate to ~/foo
cabbrev <expr> %h expand('%:h')

" SetupCommandAlias function taken from
"   https://stackoverflow.com/questions/3878692/aliasing-a-command-in-vim#answer-3879737
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

" Command line abbreviations for fugitive plugin commands
call SetupCommandAlias("gs",    "Gstatus")
call SetupCommandAlias("gc",    "Gcommit")
call SetupCommandAlias("gap",   "!git add --patch")
call SetupCommandAlias("gpush", "!git push")
call SetupCommandAlias("grp",   "!git pull --rebase")
call SetupCommandAlias("gmp",   "!git pull")

" Run black when saving python files
autocmd BufWritePre *.py execute ':Black'

" TODO undofile -> put into a tmp file
" TODO set eventignore+=FileType | setlocal bufhidden=unload | setlocal
" buftype=nowrite ... MORE ASK FENDY

" vim -w keylog -- vim keylogger
" :mks! session-name  -- remember vim sessions for reopening windows, state,
" etc
" write root-only file: :w ! sudo tee %
" TODO add fat caps lock warning
" TODO mapping for q:
" TODO ctags  -- where is this method/function/etc. defined?
" TODO cscope  -- where is this method/function/etc. called?

let not_macOS = !(system("uname -s") =~ "Darwin")
if not_macOS
  source ~/.vim/colemak/map_keys.vim
else
  " system() opens a non-interactive shell, which inits using the file defined
  " in $BASH_ENV (see `man bash`). We could pass it all of ~/.bash_profile, but
  " evaluating it all takes too long. We only need bash functions, so just
  " evaluate those.
  let $BASH_ENV = "~/.bash_functions"
  let keyboard_layout = system("current_keyboard_layout")
  if keyboard_layout ==# "Colemak\n"
    if empty($VIM_KEY_MAP_METHOD)
      source ~/.vim/colemak/map_keys.vim
    elseif $VIM_KEY_MAP_METHOD ==# "none"
      " Don't do any extra mapping. This comes in handy when debugging key maps.
    elseif $VIM_KEY_MAP_METHOD ==# "langmap"
      " In theory, I should be able to use qwerty bindings for everything except
      " insert mode using the following langmap setting:
      set langmap=pr,fe,FE,PR,gt,GT,jy,JY,lu,LU,ui,UI,yo,YO,\\;p,:P,rs,RS,sd,SD,tf,TF,dg,DG,nj,NJ,ek,EK,il,IL,o\\;,O:,kn,KN
      " I have tried this and run into undesirable behaviour in plugins that is
      " very hard to debug, although I have isolated the langmap pairs that are
      " misbehaving. After only a little testing I found these two issues:
      "
      " 1)
      " set langmap=yo
      " Open vim and enter :CtrlP. A new line will be erroneously created below
      " the cursor.
      "
      " 2)
      " set langmap=:P,O:
      " Open vim and enter :NERDTreeToggle. Press ?. The help text should
      " appear, but instead this error will be thrown:
      "   E21: Cannot make changes, 'modifiable' is off
    endif
  endif
endif
