# Debugging keymaps

## zsh

```
$ bindkey | grep "f"  # to see what option + f does, for example
```

and then use

```
$ bindkey <command> <key>
# e.g.
$ bindkey '^[f' emacs-forward-word
```

Commands are listed by `$ zle -la`, I think?


## tmux

### Control-Space doesn't send-prefix

0. Check System Settings for any OS-level shortcuts for control-space, for example to switch keyboard layouts.
0. Confirm that the terminal is receiving the keybindings by running `$ cat -v` and then pressing the Control-Space key combination. If the terminal is receiving the key combination, then characters like `^@` will appear.
