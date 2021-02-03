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

(setq doom-localleader-key ",")

(setq evil-snipe-override-evil-repeat-keys nil)  ;; Disable default "," mapping

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
(add-hook 'sh-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))

;; Include dash in word motions
(add-hook 'emacs-lisp-mode-hook #'(lambda () (modify-syntax-entry ?- "w")))
(add-hook 'scheme-mode-hook #'(lambda () (modify-syntax-entry ?- "w")))
(add-hook 'terraform-mode-hook #'(lambda () (modify-syntax-entry ?- "w")))

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

;; May not be needed
;; (when (eq system-type 'darwin)
;;   (setq racer-rust-src-path
;;         "~/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src"))

(add-hook 'python-mode-hook 'blacken-mode)

;; Align Flake8 linter max line length with Black
(setq-default flycheck-flake8-maximum-line-length 88)

;; These following navigation commands don't leave markers to jump back to
;; with evil-jump-backward (C-o). Make them add the last position to the evil
;; jump list. This is a bug and I should raise an issue in the spacemacs repo
;; to get this fixed upstream...
(evil-set-command-property 'anaconda-mode-find-assignments :jump t)  ;; python
(evil-set-command-property 'omnisharp-find-implementations-with-ido :jump t)  ;; csharp

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
    (map! :map evil-org-mode-map
          ;; Remove conflict
          :n "O" nil))

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
  ;; (define-key Info-mode-map "n" nil)
  ;; (define-key Info-mode-map "\C-n" 'Info-next)  ; originally mapped to "n"
  ;; (define-key Info-mode-map "e" nil)
  ;; (define-key Info-mode-map "i" nil) ; originally Info-index
  ;; (define-key Info-mode-map "\M-h" 'Info-help)
  ;; ;; Info-mode-map has an auxiliary motion state keymap inside of it with its
  ;; ;; own mapping for "k", which we need to override separately from the
  ;; ;; evil-motion-state-map. This may have been added by a call to
  ;; ;; evil-add-hjkl-bindings in evil-integration.el. The letters "h" "i" "j" "k"
  ;; ;; "l" are hard coded in that source file, a better fix (that will also
  ;; ;; probably remove a lot of other keymap code in this
  ;; ;; dotspacemacs/user-config) would be to add configuration to evil.
  ;; (define-key (cdr (assoc 'motion-state Info-mode-map)) "k" 'evil-ex-search-next)

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