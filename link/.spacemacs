;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     (auto-completion :disabled-for react)
     erc
     sql
     terraform
     nginx
     docker
     yaml
     html
     latex
     csharp
     python
     ruby
     (ruby :variables ruby-test-runner 'rspec)
     (ruby :variables ruby-version-manager 'rvm)
     ruby-on-rails
     markdown
     javascript
     react
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     helm
     ;; better-defaults
     emacs-lisp
     git
     ;; org
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     ;; spell-checking
     syntax-checking
     ;; version-control
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '()
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font `("Source Code Pro"
                               :size ,(if (and (= (display-pixel-width) 1280)
                                               (= (display-pixel-height) 800))
                                         12
                                       13)
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ;; Set theme for neotree
   neo-theme 'nerd
   ;; Javascript, JSON and React (jsx) indentation
   js2-basic-offset 2
   js-indent-level 2
   css-indent-offset 2
   web-mode-markup-indent-offset 2
   web-mode-css-indent-offset 2
   web-mode-code-indent-offset 2
   web-mode-attr-indent-offset 2
   js2-strict-trailing-comma-warning nil
   js2-ignored-warnings '("msg.no.side.effects" "msg.no.console")
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."
  ;; On macOS the powerline colours are slightly off. Change the powerline
  ;; separator to minimise the noise.
  (setq powerline-default-separator 'utf-8)

  ;; Save all open buffers on focus-out.
  (add-hook 'focus-out-hook (lambda () (save-some-buffers t)))

  ;; When opening a symlink, actually open the original file the symlink
  ;; points to. Especially useful when editing dotfiles that symlink into
  ;; my dotfiles repo.
  (setq find-file-visit-truename t)

  ;; Increase length of filenames in Helm mini (used when swapping between
  ;; buffers) before they are truncated
  (setq helm-buffer-max-length 30)

  ;; Set indent width of CSS and SCSS to 2 characters
  (setq css-indent-offset 2)

  ;; Make magit status buffer show fine diffs
  (setq magit-diff-refine-hunk 'all)

  ;; When the autocomplete window is open, C-w should still delete backwards.
  ;; See https://github.com/syl20bnr/spacemacs/issues/4243.
  (with-eval-after-load 'company
    (define-key company-active-map (kbd "C-w") 'evil-delete-backward-word))

  ;; Adjust ediff faces so that 'fine' diffs (that is, diffs in parts of a line)
  ;; stand out more
  (defun asnr-adjust-ediff-colours ()                      ;; ~originally~
    (set-face-foreground 'ediff-current-diff-A "#d69399")  ;; #f2241f
    (set-face-background 'ediff-current-diff-A "#512e31")  ;; #512e31
    (set-face-foreground 'ediff-fine-diff-A    "#f4b8bd")  ;; <undefined>
    (set-face-background 'ediff-fine-diff-A    "#8d252e")  ;; <undefined>
    (set-face-bold       'ediff-fine-diff-A    nil)        ;; bold
    (set-face-foreground 'ediff-current-diff-B "#93cb5c")  ;; #67b11d
    (set-face-background 'ediff-current-diff-B "#062c0c")  ;; #29422d
    (set-face-foreground 'ediff-fine-diff-B    "#9bd363")  ;; <undefined>
    (set-face-background 'ediff-fine-diff-B    "#186123")  ;; <undefined>
    (set-face-bold       'ediff-fine-diff-B    nil))       ;; bold
  (add-hook 'ediff-load-hook 'asnr-adjust-ediff-colours)

  ;; When opening magit status buffer, start the point at a useful place
  (defun asnr-adjust-magit-status-point ()
    (when (and (derived-mode-p 'magit-status-mode) (bobp))
      (let ((search-result (search-forward-regexp "^Unstaged" nil t)))
        (when search-result (forward-line)))))
  (add-hook 'magit-refresh-buffer-hook 'asnr-adjust-magit-status-point)

  ;; Include underscore in word motions
  (add-hook 'python-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
  (add-hook 'ruby-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
  (add-hook 'js2-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
  (add-hook 'react-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
  (add-hook 'c-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))

  ;; Include dash in word motions
  (add-hook 'emacs-lisp-mode-hook #'(lambda () (modify-syntax-entry ?- "w")))

  (defvar asnr-close-parens-keep-at-end-of-line ()
    "A list of close parens characters that `asnr-spread-list-to-newlines' will
keep at the end of the last line of arguments.")
  (make-variable-buffer-local 'asnr-close-parens-keep-at-end-of-line)

  (add-hook 'csharp-mode-hook
            #'(lambda () (setq asnr-close-parens-keep-at-end-of-line '(?\)))))

  (autoload 'sql-mssql "~/.config/spacemacs/sql-mssql.el" nil t)

  (asnr-configure-colemak-bindings)
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (omnisharp shut-up csharp-mode helm-company helm-c-yasnippet company-web web-completion-data company-tern tern company-statistics company-auctex company-anaconda company auto-yasnippet ac-ispell auto-complete erc-yt erc-view-log erc-terminal-notifier erc-social-graph erc-image erc-hl-nicks sql-indent terraform-mode hcl-mode flycheck-pos-tip pos-tip flycheck nginx-mode dockerfile-mode docker tablist docker-tramp auctex-latexmk projectile-rails inflections feature-mode yaml-mode web-mode tagedit slim-mode scss-mode sass-mode pug-mode less-css-mode helm-css-scss haml-mode emmet-mode auctex yapfify pyvenv pytest pyenv-mode py-isort pip-requirements live-py-mode hy-mode dash-functional helm-pydoc cython-mode anaconda-mode pythonic rvm ruby-tools ruby-test-mode rubocop rspec-mode robe rbenv rake minitest chruby bundler inf-ruby mmm-mode markdown-toc markdown-mode gh-md smeargle orgit org magit-gitflow helm-gitignore gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link evil-magit magit magit-popup git-commit with-editor web-beautify livid-mode skewer-mode simple-httpd json-mode json-snatcher json-reformat js2-refactor yasnippet multiple-cursors js2-mode js-doc coffee-mode ws-butler window-numbering which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox spinner org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint info+ indent-guide ido-vertical-mode hydra hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make projectile pkg-info epl helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu highlight elisp-slime-nav dumb-jump f s diminish define-word column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed dash aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core popup async quelpa package-build spacemacs-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yasnippet-snippets symon string-inflection spaceline-all-the-icons all-the-icons memoize ruby-refactor ruby-hash-syntax rjsx-mode pippel pipenv password-generator overseer nameless magit-svn json-navigator hierarchy importmagic epc ctable concurrent deferred impatient-mode htmlize helm-xref helm-purpose window-purpose imenu-list gitignore-templates ghub let-alist evil-lion evil-goggles evil-cleverparens paredit editorconfig counsel-projectile counsel swiper ivy company-terraform centered-cursor-mode font-lock+ dotenv-mode winum fuzzy groovy-mode omnisharp shut-up csharp-mode helm-company helm-c-yasnippet company-web web-completion-data company-tern tern company-statistics company-auctex company-anaconda company auto-yasnippet ac-ispell auto-complete erc-yt erc-view-log erc-terminal-notifier erc-social-graph erc-image erc-hl-nicks sql-indent terraform-mode hcl-mode flycheck-pos-tip pos-tip flycheck nginx-mode dockerfile-mode docker tablist docker-tramp auctex-latexmk projectile-rails inflections feature-mode yaml-mode web-mode tagedit slim-mode scss-mode sass-mode pug-mode less-css-mode helm-css-scss haml-mode emmet-mode auctex yapfify pyvenv pytest pyenv-mode py-isort pip-requirements live-py-mode hy-mode dash-functional helm-pydoc cython-mode anaconda-mode pythonic rvm ruby-tools ruby-test-mode rubocop rspec-mode robe rbenv rake minitest chruby bundler inf-ruby mmm-mode markdown-toc markdown-mode gh-md smeargle orgit org magit-gitflow helm-gitignore gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link evil-magit magit magit-popup git-commit with-editor web-beautify livid-mode skewer-mode simple-httpd json-mode json-snatcher json-reformat js2-refactor yasnippet multiple-cursors js2-mode js-doc coffee-mode ws-butler window-numbering which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox spinner org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint info+ indent-guide ido-vertical-mode hydra hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make projectile pkg-info epl helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu highlight elisp-slime-nav dumb-jump f s diminish define-word column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed dash aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core popup async quelpa package-build spacemacs-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)

(defun asnr-configure-colemak-bindings ()
  (define-key evil-motion-state-map "n" 'evil-next-line)
  (define-key evil-motion-state-map "e" 'evil-previous-line)
  (define-key evil-motion-state-map "i" 'evil-forward-char)
  ; The default binding of "i" in the normal map takes precedence over the
  ; motion map binding, so we need to delete it
  (define-key evil-normal-state-map "i" nil)
  (define-key evil-visual-state-map "i" nil)

  (define-key evil-motion-state-map "f" 'evil-forward-word-end)
  (define-key evil-motion-state-map "F" 'evil-forward-WORD-end)
  (define-key evil-motion-state-map "t" 'evil-find-char)
  (define-key evil-motion-state-map "T" 'evil-find-char-backward)
  (define-key evil-motion-state-map "g" 'evil-find-char-to)
  (define-key evil-normal-state-map "g" nil)
  (define-key evil-motion-state-map "G" 'evil-find-char-to-backward)
  (define-key evil-motion-state-map "j" 'evil-yank)
  (define-key evil-normal-state-map "d" nil)
  (define-key evil-motion-state-map "dd" 'evil-goto-first-line)
  ; Stop default binding taking precedence over end-of-buffer
  (define-key evil-normal-state-map "D" nil)
  (define-key evil-motion-state-map "D" 'end-of-buffer)
  (define-key evil-motion-state-map "E" 'evil-lookup)
  (define-key evil-motion-state-map "k" 'evil-ex-search-next)
  ; Stop default binding taking precedence over evil-search-previous
  (define-key evil-normal-state-map "K" nil)
  (define-key evil-motion-state-map "K" 'evil-ex-search-previous)
  (define-key evil-motion-state-map "zg" 'evil-scroll-line-to-top)
  ; Stop default binding taking precence over undo-tree-redo binding
  (define-key evil-normal-state-map "\C-p" nil)
  (define-key evil-motion-state-map "\C-p" 'undo-tree-redo)
  (define-key evil-motion-state-map "\C-y" 'evil-jump-backward)
  (define-key evil-motion-state-map "\C-u" 'evil-jump-forward)

  (define-key evil-normal-state-map "s" 'evil-delete)
  (define-key evil-normal-state-map "u" 'evil-insert)
  (define-key evil-normal-state-map "U" 'evil-insert-line)
  (define-key evil-normal-state-map "y" 'evil-open-below)
  (define-key evil-normal-state-map "Y" 'evil-open-above)
  (define-key evil-normal-state-map "l" 'undo)
  (define-key evil-normal-state-map ";" 'evil-paste-after)
  (define-key evil-normal-state-map ":" 'evil-paste-before)
  (define-key evil-normal-state-map "O" 'evil-ex)
  (define-key evil-normal-state-map "p" 'evil-replace)
  (define-key evil-normal-state-map "P" 'evil-replace-state)
  (define-key evil-normal-state-map "N" 'evil-join)

  (define-key evil-visual-state-map "O" 'evil-ex)
  (define-key evil-visual-state-map "U" 'evil-insert)
  (evil-define-key 'visual evil-surround-mode-map "R" 'evil-surround-region)

  ;; \C-p was originally mapped to 'evil-complete-previous
  (define-key evil-insert-state-map "\C-p" 'evil-paste-from-register)

  (define-key evil-operator-state-map "u" evil-inner-text-objects-map)
  (evil-define-key 'operator evil-surround-mode-map "r" 'evil-surround-edit)

  (spacemacs/set-leader-keys "wn" 'evil-window-down)
  (spacemacs/set-leader-keys "we" 'evil-window-up)
  (spacemacs/set-leader-keys "wi" 'evil-window-right)

  (spacemacs/declare-prefix "o" "user")
  (spacemacs/set-leader-keys "of" 'fill-region)
  (spacemacs/set-leader-keys "os" 'asnr-spread-list-to-newlines)

  ;; This breaks n mapping for Neotree for some reason
  ;; (define-key evil-evilified-state-map "n" 'evil-next-line)
  (define-key evil-evilified-state-map "e" 'evil-previous-line)
  (define-key evil-evilified-state-map "i" 'evil-forward-char)
  (define-key evil-evilified-state-map "dd" 'evil-goto-first-line)
  (define-key evil-evilified-state-map "D" 'evil-goto-line)

  (define-key Info-mode-map "n" nil)
  (define-key Info-mode-map "\C-n" 'Info-next)  ; originally mapped to "n"
  (define-key Info-mode-map "e" nil)
  (define-key Info-mode-map "i" nil) ; originally Info-index
  (define-key Info-mode-map "\M-h" 'Info-help)
  ;; Info-mode-map has an auxiliary motion state keymap inside of it with its
  ;; own mapping for "k", which we need to override separately from the
  ;; evil-motion-state-map. This may have been added by a call to
  ;; evil-add-hjkl-bindings in evil-integration.el. The letters "h" "i" "j" "k"
  ;; "l" are hard coded in that source file, a better fix (that will also
  ;; probably remove a lot of other keymap code in this
  ;; dotspacemacs/user-config) would be to add configuration to evil.
  (define-key (cdr (assoc 'motion-state Info-mode-map)) "k" 'evil-search-next)

  (with-eval-after-load 'helm
    (define-key helm-map "\C-e" 'helm-previous-line))

  (with-eval-after-load 'helm-ag
    ;; Only do this because can't use more general evil-evilified-state-map
    ;; for "n", see comment above.
    (evil-define-key 'evilified helm-ag-mode-map "n" 'evil-next-line)
    (evil-define-key 'evilified helm-ag-mode-map "e" 'evil-previous-line)
    (evil-define-key 'evilified helm-ag-mode-map "i" 'evil-forward-char))

  (with-eval-after-load 'neotree
    (evil-define-key 'evilified neotree-mode-map "n" 'neotree-next-line)
    (evil-define-key 'evilified neotree-mode-map "e" 'neotree-previous-line)
    (evil-define-key 'evilified neotree-mode-map "p" 'neotree-rename-node)
    (evil-define-key 'evilified neotree-mode-map "s" 'neotree-delete-node)
    (evil-define-key 'evilified neotree-mode-map "y" 'neotree-quick-look)
    (evil-define-key 'evilified neotree-mode-map "x" 'spacemacs/neotree-collapse-or-up))

  (with-eval-after-load 'evil-magit
    (evil-define-key evil-magit-state magit-mode-map "n" 'evil-next-line)
    (evil-define-key evil-magit-state magit-mode-map "e" 'evil-previous-line)
    (evil-define-key evil-magit-state magit-mode-map "i" 'evil-forward-char)
    (evil-define-key evil-magit-state magit-mode-map "h" 'evil-backward-char)
    (evil-define-key evil-magit-state magit-mode-map "k" 'magit-section-forward)
    (evil-define-key evil-magit-state magit-mode-map ";" 'magit-section-backward))

  (defun asnr-ediff-colemak-bindings ()
    (define-key ediff-mode-map "k" 'ediff-next-difference)
    (define-key ediff-mode-map "n" 'evil-ediff-scroll-down-1)
    (define-key ediff-mode-map "e" 'evil-ediff-scroll-up-1))
  (add-hook 'ediff-startup-hook 'asnr-ediff-colemak-bindings)
  )

(defun abc-recently-played ()
  "Run and display the output of the `abc_recently_played' commandline utility"
  (interactive)
  (let ((output-buffer-name "*ABC-radio-recently-played*"))
    ;; with-output-to-temp-buffer is a hack to open the new buffer in Help mode.
    (with-output-to-temp-buffer
      output-buffer-name
      (let ((original-max-mini-window-height max-mini-window-height))
        ;; We set max-mini-window-height to 1 to stop `shell-command' from
        ;; writing stdout to the minibuffer *as well* as the buffer we specify.
        ;; We then have to reset it to what it was previously, hence the
        ;; unwind-protect shenanigans.
        (unwind-protect
            (progn
              (setq max-mini-window-height 1)
              (shell-command "abc_recently_played jazz"
                             output-buffer-name
                             output-buffer-name)
              (pop-to-buffer output-buffer-name))
          (setq max-mini-window-height original-max-mini-window-height))))))

(defun asnr-spread-list-to-newlines ()
  (interactive)
  (save-excursion
    (asnr-last-point-in-open-parens-class)
    (let* ((open-parens-char (char-after))
           (close-parens-char (asnr-matching-parens-character open-parens-char)))
      (forward-char)
      (asnr-newline-indented)
      (asnr-spread-list-contents-to-newlines open-parens-char
                                             close-parens-char))))

(defun asnr-spread-list-contents-to-newlines (open-parens-char close-parens-char)
  (let ((next-token (regexp-opt (list (string open-parens-char)
                                      (string close-parens-char)
                                      ","))))
    (re-search-forward next-token)  ;; TODO: error handling
    (let ((matched-char (char-before)))
      (while (not (= matched-char close-parens-char))
        (cond ((= matched-char ?,) (asnr-newline-indented))
              ((= matched-char open-parens-char) (progn
                                                   (backward-char)
                                                   (forward-list))))
        (re-search-forward next-token)
        (setq matched-char (char-before)))
      (when (asnr-close-parens-on-newline-p close-parens-char)
        (backward-char)
        (when (= (char-before) ?\s) (backward-char))
        (insert ",")
        (asnr-newline-indented)))))

(defun asnr-close-parens-on-newline-p (close-parens-char)
  (not (seq-contains asnr-close-parens-keep-at-end-of-line close-parens-char)))

(defun asnr-last-point-in-open-parens-class ()
  (interactive)
  (let* ((open-parens-strings (mapcar 'string (asnr-open-parens-characters)))
         (open-parens-regex (regexp-opt open-parens-strings)))
    ;; Move forward to deal with case where cursor is at open parens
    (forward-char)
    (re-search-backward open-parens-regex)))

(defun asnr-matching-parens-character (open-parens-character)
  "Return the matching parenthesis character as defined by the current syntax
table."
  (let* ((raw-syntax-descriptor (char-table-range (syntax-table)
                                                  open-parens-character))
         (matching-parens-character (cdr raw-syntax-descriptor)))
    matching-parens-character))

(defun asnr-newline-indented ()
  (newline)
  (indent-according-to-mode))

(defun asnr-characters-in-syntax-class (syntax-class-code)
  "Returns a list containing all the characters that belong to
the syntax class defined by the integer SYNTAX-CLASS-CODE (e.g. 4
for open parenthesis syntax class), as defined by the current
syntax table.

Note that this function does not examine parent syntax tables,
so the list may appear incomplete."
  (let* ((parens-group ())
         (add-to-group (lambda (key value)
                         (let ((syntax-class (car value)))
                           (when (= syntax-class syntax-class-code)
                             (setq parens-group (cons key parens-group)))))))
    (map-char-table add-to-group (syntax-table))
    parens-group))

(defun asnr-open-parens-characters ()
  "Returns list of characters that are in the 'open paranthesis'
syntax class as defined in the current syntax table.

Note that we our implementation is hacky: we start with a list of
likely open parenthesis characters and we check which ones are
actually in the open paranthesis syntax table.

A more robust solution would traverse the syntax table and
collect all of the characters in the syntax class, but this is a
huge pain in the arse; see `asnr-characters-in-syntax-class'."
  (let* ((possible-open-parens '(?\( ?\{ ?\[))
         (OPEN-PARENS-SYNTAX-CLASS ?\()
         (valid-open-parens-p (lambda (c) (= OPEN-PARENS-SYNTAX-CLASS
                                             (char-syntax c))))
         (open-parens-characters (seq-filter valid-open-parens-p
                                             possible-open-parens)))
    open-parens-characters))
