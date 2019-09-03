(check-and-install-package 'flycheck 'flycheck-rust 'flycheck-pos-tip 'add-node-modules-path)

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'python-mode-hook #'flycheck-mode)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

(eval-after-load "flycheck-mode"
  '(when window-system
     (with-eval-after-load 'flycheck
       (flycheck-pos-tip-mode))))

(setq css-indent-offset 2)

(eval-after-load 'js-mode
  '(add-hook 'js-mode-hook #'add-node-modules-path))
