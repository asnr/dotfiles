# Dotfiles

1. Run $ ./go.sh

2. vim: install [vundle](https://github.com/VundleVim/Vundle.vim) and then install vim plugins.
   1. `$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
   2. Open vim and run `:PluginInstall`


## macOS

### terminal

**Personalise terminal.** Open the finder window in the terminal directory and open up the terminal preferences window next to it. Drag the terminal/asnr.terminal file from the finder window to the terminal preferences window. Adjust the font size if necessary and set the "asnr" profile to default.

### emacs

**Make emacs findable from Spotlight.** If installing emacs from brew, make it findable from Spotlight by finding the executable in Finder, right click, "make alias", drag alias file to the Applications folder.

**Allow emacs to delete files.** If deleting files inside emacs (e.g. via SPC f D) doesn't work, then check macOS security isn't blocking emacs access to Finder. In System Preferences go to Security & Privacy -> Privacy tab -> Automation. If Emacs is in the application list, make sure the "Finder" checkbox under it is enabled.

### tmux

If using tmux, install helper binary `$ brew install reattach-to-user-namespace`

