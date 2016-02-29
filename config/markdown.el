(unless (package-installed-p 'markdown-mode)
  (package-refresh-contents) (package-install 'markdown-mode))

(add-hook
 'after-init-hook
 '(lambda ()
    (progn
      ;; markdown-mode
      (autoload 'markdown-mode "markdown-mode"
        "Major mode for editing Markdown files" t)
      (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
      (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode)))))
