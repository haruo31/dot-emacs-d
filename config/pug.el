(check-and-install-package 'pug-mode 'js-auto-format-mode)

(add-hook 'js-mode-hook #'js-auto-format-mode)
(add-hook 'js-mode-hook #'add-node-modules-path)

(setq pug-tab-width 2)
