(unless (package-installed-p 'flycheck)
  (package-refresh-contents) (package-install 'flycheck))

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'python-mode-hook #'flycheck-mode)
