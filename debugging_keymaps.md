# Debugging keymaps

## emacs

- C-h k (describe-key). Press C-h k, then press the key combination you want to check. Emacs will show you what command it's bound to.
- C-h w (where-is). For when you know the command name and want to find find which keys are bound to it.
- C-h b (describe-bindings). This displays all current key bindings in a buffer. It's useful for browsing all available bindings in the current mode.


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
