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
