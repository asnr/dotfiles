;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

(setq doom-font (font-spec :family "monospace" :size 14))

(setq doom-theme 'doom-solarized-light)
(setq doom-solarized-light-brighter-comments t)

(setq org-directory "~/org/")  ;; must be set before org loads

(setq display-line-numbers-type nil)

;; Maximize window on startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Automatically save all open buffers when compiling
(setq compilation-ask-about-save nil)

;; Save all open buffers on focus-out.
(add-function :before after-focus-change-function (lambda () (save-some-buffers t)))

;; When opening a symlink, actually open the original file the symlink
;; points to. Especially useful when editing dotfiles that symlink into
;; my dotfiles repo.
(setq find-file-visit-truename t)

(setq confirm-kill-emacs nil)  ;; don't ask for confirmation before quitting

;; Disable to speed up line-by-line scrolling of files with many lines
(setq doom-modeline-buffer-state-icon nil)

(setq doom-localleader-key ",")

(setq evil-snipe-override-evil-repeat-keys nil)  ;; Disable default "," mapping


(defun asnr-focus-on-window ()
  (interactive)
  (delete-other-windows)
  (split-window-right))

(map! :leader :desc "Focus on window" "w f" #'asnr-focus-on-window)
;; Overwrite Doom emacs default, counsel-evil-registers
(map! :leader :desc "Show kill ring" "i r" #'counsel-yank-pop)

(after! winum
  (map! :leader :desc "Window 1" "1" #'winum-select-window-1)
  (map! :leader :desc "Window 2" "2" #'winum-select-window-2)
  (map! :leader :desc "Window 3" "3" #'winum-select-window-3)
  (map! :leader :desc "Window 4" "4" #'winum-select-window-4)
  (map! :leader :desc "Window 5" "5" #'winum-select-window-5)
  (map! :leader :desc "Window 6" "6" #'winum-select-window-6))


;; keybind to disable search highlighting (like :set noh)
(map! :leader
      :desc "Clear search highlight"
      "s c"
      #'evil-ex-nohighlight)

(after! magit
  ;; Make magit status buffer show fine diffs
  (setq magit-diff-refine-hunk 'all)

  ;; Automatically save file-visiting buffers before doing magit things
  (setq magit-save-repository-buffers 'dontask)

  ;; Remove overlong-summary-line check when writing commit message
  (setq git-commit-style-convention-checks '(non-empty-second-line))

  ;; When opening magit status buffer, start the point at a useful place
  (defun asnr-adjust-magit-status-point ()
    (when (and (derived-mode-p 'magit-status-mode) (bobp))
      (let ((search-result (search-forward-regexp "^Unstaged" nil t)))
        (when search-result (forward-line)))))
  (add-hook 'magit-refresh-buffer-hook 'asnr-adjust-magit-status-point))


;; Enable word wrap in org mode
(add-hook 'org-mode-hook #'toggle-truncate-lines)

;; Include underscore in word motions
(add-hook 'python-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'ruby-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'js2-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'react-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'c-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'c++-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'sh-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'terraform-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'yaml-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))

;; Include dash in word motions
(add-hook 'emacs-lisp-mode-hook #'(lambda () (modify-syntax-entry ?- "w")))
(add-hook 'scheme-mode-hook #'(lambda () (modify-syntax-entry ?- "w")))
(add-hook 'terraform-mode-hook #'(lambda () (modify-syntax-entry ?- "w")))

(setq js-indent-level 2)

;; All these "spacemacs/" functions come from spacemacs
(defun spacemacs/projectile-copy-file-path ()
  "Retrieve the file path relative to project root.

Returns:
  - A string containing the file path in case of success.
  - `nil' in case the current buffer does not visit a file."
  (interactive)
    (if-let (file-path (spacemacs--projectile-file-path))
        (progn
          (kill-new file-path)
          (message "%s" file-path))
      (message "WARNING: Current buffer is not visiting a file!")))

;; Taken straight from spacemacs
(defun spacemacs--projectile-file-path ()
  "Retrieve the file path relative to project root.

Returns:
  - A string containing the file path in case of success.
  - `nil' in case the current buffer does not visit a file."
  (when-let (file-name (buffer-file-name))
    (file-relative-name (file-truename file-name) (projectile-project-root))))

(defun spacemacs/projectile-copy-file-path-with-line ()
  "Copy and show the file path relative to project root, including line number."
  (interactive)
  (if-let (file-path (spacemacs--projectile-file-path-with-line))
      (progn
        (kill-new file-path)
        (message "%s" file-path))
    (message "WARNING: Current buffer is not visiting a file!")))

;; Taken straight from spacemacs
(defun spacemacs--projectile-file-path-with-line ()
  "Retrieve the file path relative to project root, including line number.

Returns:
  - A string containing the file path in case of success.
  - `nil' in case the current buffer does not visit a file."
  (when-let (file-path (spacemacs--projectile-file-path))
    (concat file-path ":" (number-to-string (line-number-at-pos)))))


(map! :leader
      (:prefix "f"
       (:prefix-map ("y" . "yank")
        :desc "Yank filename"          "y" #'+default/yank-buffer-filename
        :desc "Yank project file path" "Y" #'spacemacs/projectile-copy-file-path
        :desc "Yank file path:line no" "L" #'spacemacs/projectile-copy-file-path-with-line)))

(add-hook 'python-mode-hook 'blacken-mode)
(add-hook 'python-mode-hook 'asnr-drop-some-py2-symbols)


;; Align Flake8 linter max line length with Black
(setq-default flycheck-flake8-maximum-line-length 88)

;; These following navigation commands don't leave markers to jump back to
;; with evil-jump-backward (C-o). Make them add the last position to the evil
;; jump list. This is a bug and I should raise an issue in the doom-emacs (?)
;; repo to get this fixed upstream...
(evil-set-command-property 'anaconda-mode-find-assignments :jump t)  ;; python
(evil-set-command-property 'anaconda-mode-find-definitions :jump t)  ;; python
(evil-set-command-property 'anaconda-mode-find-references :jump t)  ;; python
(evil-set-command-property 'omnisharp-find-implementations-with-ido :jump t)  ;; csharp
(evil-set-command-property 'end-of-buffer :jump t)

;; Disable the doom-emacs default Python template.
(set-file-template! 'python-mode :ignore t)

(after! org
  (setq org-startup-folded 'show2levels))

(after! terraform-mode
  ;; terraform-mode hard codes face values instead of deferring to general
  ;; faces. Adjust the particularly hard to read faces. A fix similar to this
  ;; should be made upstream.
  (setq terraform--resource-name-face 'font-lock-function-name-face)
  (setq terraform--resource-type-face 'font-lock-function-name-face))

(defun gcp-browse-pubsub-ui ()
  "Open browser to view pubsub resource at the current point."
  (interactive)
  (save-excursion
    (let* ((pubsub-id-start (progn
                                 (forward-whitespace -1)
                                 (forward-whitespace 1)
                                 (point)))
           (pubsub-id-end (progn
                               (forward-whitespace 1)
                               (forward-whitespace -1)
                               (point)))
           (pubsub-id (buffer-substring pubsub-id-start pubsub-id-end))
           (pubsub-url (gcp-build-pubsub-url pubsub-id)))
      (message "Visiting Pub/Sub URL %s" pubsub-url)
      (browse-url pubsub-url))))

(defconst gcp-pubsub-id-regex
  (concat "projects/"
          "\\([-_a-zA-Z0-9]+\\)"
          "/\\(topics\\|subscriptions\\)/"
          "\\([-_a-zA-Z0-9]+\\)"))

(defun gcp-build-pubsub-url (pubsub-id)
  (string-match gcp-pubsub-id-regex pubsub-id)
  (let* ((project-id (match-string 1 pubsub-id))
         (type (match-string 2 pubsub-id))
         (type-slug (if (string= type "topics") "topic" "subscription"))
         (name (match-string 3 pubsub-id)))
    (format "https://console.cloud.google.com/cloudpubsub/%s/detail/%s?project=%s"
            type-slug
            name
            project-id)))

(defun asnr-drop-some-py2-symbols ()
  "Stop highlighting some python 2 builtins. They make really good variable names."
  (setcar (car (nthcdr 3 python-font-lock-keywords-level-2))
        (rx symbol-start
          (or
           "abs" "all" "any" "bin" "bool" "callable" "chr" "classmethod"
           "compile" "complex" "delattr" "dict" "dir" "divmod" "enumerate"
           "eval" "filter" "float" "format" "frozenset" "getattr" "globals"
           "hasattr" "hash" "help" "hex" "id" "input" "int" "isinstance"
           "issubclass" "iter" "len" "list" "locals" "map" "max" "memoryview"
           "min" "next" "object" "oct" "open" "ord" "pow" "print" "property"
           "range" "repr" "reversed" "round" "set" "setattr" "slice" "sorted"
           "staticmethod" "str" "sum" "super" "tuple" "type" "vars" "zip"
           "__import__"
           ;; Python 2 [asnr: I HAVE REMOVED SEVERAL OF THESE]:
           "basestring" "cmp" "execfile" "long" "reduce"
           "reload" "unichr" "unicode" "xrange" "apply" "coerce"
           "intern"
           ;; Python 3:
           "ascii" "breakpoint" "bytearray" "bytes" "exec"
           ;; Special attributes:
           ;; https://docs.python.org/3/reference/datamodel.html
           "__annotations__" "__closure__" "__code__"
           "__defaults__" "__dict__" "__doc__" "__globals__"
           "__kwdefaults__" "__name__" "__module__" "__package__"
           "__qualname__"
           ;; Extras:
           "__all__")
          symbol-end)))

(defun asnr-configure-colemak-bindings ()
  (after! evil
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
    (define-key evil-visual-state-map "g" nil)

    (define-key evil-motion-state-map "G" 'evil-find-char-to-backward)
    (define-key evil-motion-state-map "j" 'evil-yank)
    (define-key evil-normal-state-map "d" nil)
    (define-key evil-motion-state-map "dd" 'evil-goto-first-line)
    (define-key evil-motion-state-map "dc" 'evilnc-comment-operator)
    ; Stop default binding taking precedence over end-of-buffer
    (define-key evil-normal-state-map "D" nil)
    (define-key evil-motion-state-map "D" 'end-of-buffer)
    (define-key evil-motion-state-map "E" 'evil-lookup)
    (define-key evil-motion-state-map "k" 'evil-ex-search-next)
    ; Stop default binding taking precedence over evil-search-previous
    (define-key evil-normal-state-map "K" nil)
    (define-key evil-motion-state-map "K" 'evil-ex-search-previous)
    (define-key evil-motion-state-map "zg" 'evil-scroll-line-to-top)
    ; Stop default binding taking precedence over undo-tree-redo binding
    (define-key evil-normal-state-map "\C-p" nil)
    (define-key evil-motion-state-map "\C-p" 'evil-redo)
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
    (define-key evil-visual-state-map "R" 'evil-surround-region)

    ;; \C-p was originally mapped to 'evil-complete-previous
    (define-key evil-insert-state-map "\C-p" 'evil-paste-from-register)

    (define-key evil-operator-state-map "u" evil-inner-text-objects-map)
    (evil-define-key 'operator evil-surround-mode-map "r" 'evil-surround-edit))

  (after! outline
    (map! :map outline-mode-map
          ;; These "g" bindings conflict with evil-find-char-to binding
          :n "gk" nil
          :n "gj" nil
          :n "g" nil))

  ; Override the mapping inside an auxiliary keymap taking precedence over the
  ; binding for `evil-find-char-to'
  (after! evil-surround
    (define-key (cdr (assoc 'visual-state evil-surround-mode-map)) "g" nil))

  (after! evil-org
    ;; Don't include 'textobjects in key theme because it breaks "i" binding in
    ;; visual mode
    (evil-org-set-key-theme '(navigation insert additional calendar))
    (map! :map evil-org-mode-map
          ;; Remove conflict
          :n "O" nil)

    ;; Override the mapping inside an auxiliary keymap taking precedence over
    ;; the binding for `evil-find-char-to'
    (define-key (cdr (assoc 'motion-state evil-markdown-mode-map)) "g" nil)
    ;; Move the mappings inside the keymap cleared above to their correct colemak location.
    ;; Essentially a copy-paste of the body of`evil-org--populate-navigation-bindings'
    (map! :map evil-org-mode-map
          :m "th" #'org-up-element
          :m "ti" #'org-down-element
          :m "te" #'org-backward-element
          :m "tn" #'org-forward-element
          :m "tH" #'evil-org-top))

  (after! evil-markdown
    ;; Override the mapping inside an auxiliary keymap taking precedence over
    ;; the binding for `evil-find-char-to'
    (define-key (cdr (assoc 'motion-state evil-markdown-mode-map)) "g" nil)
    ;; Move the mappings inside the keymap cleared above to their correct colemak location.
    ;; Essentially a copy-paste of the body of`evil-markdown--populate-navigation-bindings'
    (map! :map evil-markdown-mode-map
          :m "th" 'markdown-up-heading
          :m "ti" (lambda () (interactive) (markdown-next-heading))
          :m "te" 'markdown-backward-same-level
          :m "tn" 'markdown-forward-same-level))

  (map! :leader :desc "Window down" "w n" #'evil-window-down)
  (map! :leader :desc "Window down" "w e" #'evil-window-up)
  (map! :leader :desc "Window down" "w i" #'evil-window-right)

  (after! magit
    (map! :map  magit-mode-map
          :n "n" 'evil-next-line
          :n "e" 'evil-previous-line
          :n "i" 'evil-forward-char
          :n "h" 'evil-backward-char
          :n "k" 'evil-ex-search-next
          ;; Need to find a  binding for 'magit-section-forward (orig, "k")
          :n ";" 'magit-section-backward)

    ;; Clear bindings so that jump to start and end work correctly. Also remove
    ;; the binding listing from the transient buffer that pops up when you press
    ;; '?' in magit. I should really just move these mappings to C-d and C-D at
    ;; some point rather than removing them completely.
    (define-key magit-mode-map "d" nil)
    (define-key magit-mode-map "D" nil)
    (transient-remove-suffix 'magit-dispatch '(0 0 6))
    (transient-remove-suffix 'magit-dispatch '(0 0 5))
    ;; Need to clear bindings so that yank works correctly
    (define-key magit-mode-map "j" nil)

    (define-key magit-blame-read-only-mode-map "n" nil)
    (define-key magit-blob-mode-map "n" nil))

  (after! ivy
    (define-key ivy-minibuffer-map "\C-e" 'previous-line))

  (after! (info evil-collection)
    (map! :map Info-mode-map :n "n" nil)
    (define-key Info-mode-map "n" nil)
    (map! :map Info-mode-map :n "e" nil)
    (define-key Info-mode-map "e" nil)
    (map! :map Info-mode-map :n "i" nil)
    (define-key Info-mode-map "i" nil)
    (map! :map Info-mode-map :n "\C-n" nil)
    (define-key Info-mode-map "\M-h" 'Info-help))
  ;; ;; Info-mode-map has an auxiliary motion state keymap inside of it with its
  ;; ;; own mapping for "k", which we need to override separately from the
  ;; ;; evil-motion-state-map. This may have been added by a call to
  ;; ;; evil-add-hjkl-bindings in evil-integration.el. The letters "h" "i" "j" "k"
  ;; ;; "l" are hard coded in that source file, a better fix (that will also
  ;; ;; probably remove a lot of other keymap code in this
  ;; ;; dotspacemacs/user-config) would be to add configuration to evil.
  ;; (define-key (cdr (assoc 'motion-state Info-mode-map)) "k" 'evil-ex-search-next)

  (after! (evil-collection grep)
    ;; grep-mode-map is active in ivy-occur buffers
    (map! :map grep-mode-map :n "n" nil)
    (define-key grep-mode-map (kbd "n") nil)
    (map! :map ivy-occur-grep-mode-map :m "RET" 'next-error))

  (after! 'evil-iedit-state
    (define-key evil-iedit-state-map "n" nil)
    (define-key evil-iedit-state-map "N" 'iedit-expand-down-a-line)
    (define-key evil-iedit-state-map "E" 'iedit-expand-up-a-line)
    (define-key evil-iedit-state-map "I" 'iedit-restrict-current-line)
    (define-key evil-iedit-state-map "k" 'iedit-next-occurrence)
    (define-key evil-iedit-state-map "K" 'iedit-prev-occurrence)
    (define-key evil-iedit-state-map "dd" 'iedit-goto-first-occurrence)
    (define-key evil-iedit-state-map "D" 'iedit-goto-last-occurrence)
    (define-key evil-iedit-state-map "S" 'iedit-delete-occurrences)
    (define-key evil-iedit-state-map "r" 'evil-iedit-state/evil-substitute)
    (define-key evil-iedit-state-map "R" 'evil-iedit-state/substitute)
    ;; This isn't a Colemak fix, just aligning change with how it works with
    ;; other forms of selection, like visual and vertical visual selection.
    (define-key evil-iedit-state-map "c" 'evil-iedit-state/substitute)
    (define-key evil-iedit-state-map "T" 'iedit-restrict-function)
    (define-key evil-iedit-state-map "L" 'iedit-upcase-occurrences)
    (define-key evil-iedit-state-map (kbd "C-L") 'iedit-downcase-occurrences)))

(asnr-configure-colemak-bindings)
