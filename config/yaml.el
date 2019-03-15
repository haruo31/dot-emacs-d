(check-and-install-package 'yaml-mode 'toml)

(require 'toml)
(require 'yaml-mode)
(add-hook 'yaml-mode-hook
          (lambda ()
            (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
