(require 'sql)

(defcustom sql-mssql-program "sqlcmd"
  "Command to start Microsoft SQLServer client"
  :type 'file
  :group 'SQL)

(defcustom sql-mssql-login-params '(user password server database)
  "List of login parameters needed to connect to Microsoft SQLServer."
  :type 'sql-login-params
  ;; :version "???"
  :group 'SQL)

(defcustom sql-mssql-options '("-w" "1000")
  "List of additional options for `sqlcmd'"
  :type '(repeat string)
  ;; :version "???"
  :group 'SQL)

(defun sql-comint-mssql (product options)
  "Connect to Microsoft SQLServer in a comint buffer"
  (let ((params
         (append
          (if (not (string= "" sql-user))
              (list "-U" sql-user))
          (if (not (string= "" sql-database))
              (list "-d" sql-database))
          (if (not (string= "" sql-server))
              (list "-S" sql-server))
          options)))
    (setq params
          (if (not (string= "" sql-password))
              `("-P" ,sql-password ,@params)
            (if (string= "" sql-user)
                ;; If neither user nor password is provided, use system
                ;; credentials.
                `("-E" ,@params)
              ;; If -P is passed to sqlcmd as the last argument without a
              ;; password, it's considered null.
              `(,@params "-P"))))
    (sql-comint product params)))

(setq sql-mssql-product
      '(mssql
        :name "Miscrosoft SQLServer (via sqlcmd)"
        :font-lock sql-mode-ms-font-lock-keywords
        :syntax-alist ((?@ . "_"))
        :sqli-program sql-mssql-program
        :prompt-regexp "^[0-9]*>"
        ;; This is the same as `prompt-regexp', but we include it because there
        ;; is a bug in `sql-interactive-remove-continuation-prompt' that causes
        ;; a (stringp nil) error after a call to `string-match'.
        :prompt-cont-regexp "^[0-9]*>"
        :prompt-length 5
        :sqli-login sql-mssql-login-params
        :sqli-options sql-mssql-options
        :sqli-comint-func sql-comint-mssql))


;; We should be using `sql-add-product' and `sql-set-product-feature' functions
;; instead of manipulating the underlying data structures directly, but the
;; `sql-set-product-feature' function has bug in it. It fails when you try to
;; add a feature that isn't already present in the plist but is included in the
;; `sql-indirect-feature' list. For example,
;;
;;   (sql-add-product 'mssql "Miscrosoft SQLServer (via sqlcmd)")
;;   (sql-set-product-feature 'mssql :font-lock 'sql-mode-mssql-font-lock-keywords)
;;
;; fails.
(setq sql-product-alist
      (cons sql-mssql-product sql-product-alist))

;; (sql-add-product 'mssql "Miscrosoft SQLServer (via sqlcmd)")
;; (sql-set-product-feature 'mssql :font-lock 'sql-mode-mssql-font-lock-keywords)
;; (sql-set-product-feature 'mssql :syntax-alist '((?@ . "_")))
;; (sql-set-product-feature 'mssql :sqli-program 'sql-mssql-program)
;; (sql-set-product-feature 'mssql :prompt-regexp "^[0-9]*>")
;; (sql-set-product-feature 'mssql :prompt-length 5)
;; (sql-set-product-feature 'mssql :sqli-login 'sql-mssql-login-params)
;; (sql-set-product-feature 'mssql :sqli-options 'sql-mssql-options)
;; (sql-set-product-feature 'mssql :sqli-comint-func 'sql-comint-mssql)

(defun asnr-message-sqlcmd-output (sqlcmd-output)
  (message "sqlcmd:")
  (message sqlcmd-output)
  sqlcmd-output)

(defun sql-mssql (&optional buffer)
  "Run sqlcmd by Microsoft SQLServer as an inferior process."
  (interactive "P")
  (sql-product-interactive 'mssql buffer)
  (message "buffer-name: %s" (buffer-name))
  ;; Copy output of sqlcmd verbatim to the Messages buffer for debugging
  (add-hook 'comint-preoutput-filter-functions 'asnr-message-sqlcmd-output))
