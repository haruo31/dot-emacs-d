(unless (package-installed-p 'flycheck)
  (package-refresh-contents) (package-install 'flycheck))

(unless (package-installed-p 'flycheck-pos-tip)
  (package-refresh-contents) (package-install 'flycheck-pos-tip))
(unless (package-installed-p 'flycheck-rust)
  (package-refresh-contents) (package-install 'flycheck-rust))

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'python-mode-hook #'flycheck-mode)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

(eval-after-load "flycheck-mode"
  '(when window-system
     (with-eval-after-load 'flycheck
       (flycheck-pos-tip-mode))))
