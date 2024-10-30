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

Setup steps. These don't need to be followed exactly.

1. Install xcode tools by typing running `git` at the terminal, xcode tools download will be autotriggered.
2. Personalise the terminal, see the "terminal" section below.
3. Install brew, see https://brew.sh/.
4. Install a newer version of bash, `brew install bash`, and have terminal.app open this version by default. See the comment above the PS1 code.
5. `brew install tmux` and see the "tmux" section below.
6. Install emacs, see the "emacs" section below.


### terminal

**Personalise terminal.** Open the terminal preferences window. Under "Profiles", import the profile defined in the terminal/asnr.terminal file. Adjust the font size if necessary and set the "asnr" profile to default.

### emacs

```
$ brew uninstall emacs-plus@28
$ brew tap d12frosted/emacs-plus
$ brew install emacs-plus@29 --with-modern-doom3-icon
```

**Make emacs findable from Spotlight.** If installing emacs from brew, make it findable from Spotlight by finding the executable in Finder, right click, "make alias", drag alias file to the Applications folder.

**Allow emacs to delete files.** If deleting files inside emacs (e.g. via SPC f D) doesn't work, then check macOS security isn't blocking emacs access to Finder. In System Preferences go to Security & Privacy -> Privacy tab -> Automation. If Emacs is in the application list, make sure the "Finder" checkbox under it is enabled.

### tmux

If using tmux, install helper binary `$ brew install reattach-to-user-namespace`


### zsh

I used the default zsh installed with macOS (version 5.9).


## Brew

Install old version of a formula that doesn't have an `@` version available: https://stackoverflow.com/a/76384322.


## Music

### Combining songs into an album in Apple Music

1. Go to the "Songs" view.
2. Multi-select the songs in the song list.
3. Right-click and select "Get Info".
4. Select the checkbox "Album is a compilation of songs by various artists".
