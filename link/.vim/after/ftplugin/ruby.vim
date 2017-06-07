" Ruby specific settings

set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2
set autoindent
set colorcolumn=81

" Add `end` and then place cursor on previous line on Shift-Enter.
" For example, starting from here:
"
"   def some_method[<- cursor]
"
" after pressing Shift-Enter, you will be here:
"
"   def some_method
"     [<- cursor]
"   end
"
" Note: to get this to work in iTerm2, you need to:
" Open iTerm2 preferences -> profile -> keys -> add more key + ->
" press Shift Enter in field Keyboard Shortcut ->
" action: Send Text with “vim” Special Char -> past in `\n\nend\x1B-cc`
imap <S-CR> <CR><CR>end<Esc>-cc
