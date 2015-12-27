(unless (package-installed-p 'yaml-mode)
  (package-refresh-contents) (package-install 'yaml-mode))

(require 'yaml-mode)
(add-hook 'yaml-mode-hook
          (lambda ()
            (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
