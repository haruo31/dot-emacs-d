(unless (package-installed-p 'rust-mode)
  (package-refresh-contents) (package-install 'rust-mode))
(unless (package-installed-p 'racer)
  (package-refresh-contents) (package-install 'racer))

(add-hook
 'after-init-hook
 '(lambda ()
    (progn
      (autoload 'rust-mode "rust-mode"
        "Major mode for rust lang" t)
      (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
      (add-hook 'rust-mode-hook #'racer-mode)
      (add-hook 'racer-mode-hook #'eldoc-mode)
      (add-hook 'racer-mode-hook #'company-mode))))
