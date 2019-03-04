(check-and-install-package 'flycheck 'flycheck-rust 'flycheck-pos-tip)

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'python-mode-hook #'flycheck-mode)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

(eval-after-load "flycheck-mode"
  '(when window-system
     (with-eval-after-load 'flycheck
       (flycheck-pos-tip-mode))))
