(unless (package-installed-p 'flycheck)
  (package-refresh-contents) (package-install 'flycheck))

(unless (package-installed-p 'flycheck-pyflakes)
  (package-refresh-contents) (package-install 'flycheck-pyflakes))
(unless (package-installed-p 'flycheck-pos-tip)
  (package-refresh-contents) (package-install 'flycheck-pos-tip))

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'python-mode-hook #'flycheck-mode)
;; epylint へパスが通っていないとシンタックスチェックが働かない
;; (setq exec-path (cons "/usr/local/bin" exec-path))

(eval-after-load 'flycheck
  '(custom-set-variables
   '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))
