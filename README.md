# Dotfiles

## First time setup

1. Run `$ ./go.sh`

1. For a work computer, create the file `~/.gitconfig_work` with the contents (note indentation is done with tab characters)

   ```
   [user]
   	name = ...
   	email = ...
   ```


## macOS

### terminal

**Personalise terminal.** Open the terminal preferences window. Under "Profiles", import the profile defined in the terminal/asnr.terminal file. Adjust the font size if necessary and set the "asnr" profile to default.

### emacs

```
$ brew uninstall emacs-plus@27
$ brew tap d12frosted/emacs-plus
$ brew install emacs-plus@28 --with-modern-doom3-icon
```

**Make emacs findable from Spotlight.** If installing emacs from brew, make it findable from Spotlight by finding the executable in Finder, right click, "make alias", drag alias file to the Applications folder.

**Allow emacs to delete files.** If deleting files inside emacs (e.g. via SPC f D) doesn't work, then check macOS security isn't blocking emacs access to Finder. In System Preferences go to Security & Privacy -> Privacy tab -> Automation. If Emacs is in the application list, make sure the "Finder" checkbox under it is enabled.

### tmux

If using tmux, install helper binary `$ brew install reattach-to-user-namespace`

