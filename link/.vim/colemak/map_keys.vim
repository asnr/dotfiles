noremap n j
noremap N J
noremap e k
noremap i l
noremap I L
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
" Can't enable this map until we fix fugitive mappings, otherwise there's no
" way to enter command mode from a fugitive window.
" noremap : P
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
noremap g t
noremap ug it
noremap ag at
noremap t f
noremap dt gf
noremap <C-W>i <C-W>l
noremap <C-W>n <C-W>j
noremap <C-W>e <C-W>k
noremap <C-W>y <C-W>o
noremap zy zo
noremap zY zO
noremap zp zr
noremap zP zR
noremap zg zt

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

" We really want <space> to be leader, but if we mapleader=' ', then we don't
" get any visual indication in the bottom right of the command corner when we
" press the leader key
let mapleader='\'
map <space> \
noremap \s :CtrlP<CR>
noremap \t :NERDTreeToggle<CR>
noremap \; :r !pbpaste<CR>
noremap \h <C-w>h
noremap \n <C-w>j
noremap \e <C-w>k
noremap \i <C-w>l
noremap \w :w<CR>
noremap \q :q<CR>
noremap \x :split<CR>
noremap \v :vsplit<CR>
noremap \k :noh<CR>
" These three aren't working for some reason. Try with single character
" shortcut?
" noremap \cu <plug>NERDCommenterInvert
" noremap \ci <plug>NERDCommenterAlignLeft
" noremap \cl <plug>NERDCommenterUncomment

" Map CtrlP to an out of the way combination so that it doesn't conflict with
" redo (<C-R>)
let g:ctrlp_map = '<C-\>'

" Make NERDTree mappings play well with my Colemak adjusted mappings.
" For example, by default NERDTreeMapOpenExpl = 'e' stuffs up my
" Colemak-adjusted up-navigation so we remap it to where Colemak maps
" 'e'.
let NERDTreeMapRefresh = 'p'
let NERDTreeMapRefreshRoot = 'P'
let NERDTreeMapOpenExpl = 'f'
let NERDTreeMapActivateNode = 'y'
let NERDTreeMapPreview = 'dy'
let NERDTreeMapOpenRecursively = 'Y'
let NERDTreeMapOpenSplit = '<leader>x'
let NERDTreeMapPreviewSplit = 'dx'
let NERDTreeMapOpenVSplit = '<leader>v'
let NERDTreeMapPreviewVSplit = 'dv'
let NERDTreeMapJumpFirstChild = 'E'
let NERDTreeMapJumpLastChild = 'N'
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

" fugitive_no_maps is a misnomer, it only disables <C-R><C-G> and y<C-G>.
" We really care about disabling the latter, because that makes the remapped
" colemak 'y' open a new line instantly, instead of having to wait in case you
" want to add an extra <C-G>
let g:fugitive_no_maps=1
