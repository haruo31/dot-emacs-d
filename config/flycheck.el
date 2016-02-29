(unless (package-installed-p 'flycheck)
  (package-refresh-contents) (package-install 'flycheck))

;;(unless (package-installed-p 'flycheck-pyflakes)
;;  (package-refresh-contents) (package-install 'flycheck-pyflakes))
(unless (package-installed-p 'flycheck-pos-tip)
  (package-refresh-contents) (package-install 'flycheck-pos-tip))

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'python-mode-hook #'flycheck-mode)
;; epylint へパスが通っていないとシンタックスチェックが働かない
(if (eq system-type 'darwin)
    (setq exec-path (cons "/usr/local/bin" exec-path)))

(eval-after-load "flycheck-mode"
  '(when window-system
     (with-eval-after-load 'flycheck
       (flycheck-pos-tip-mode))))
