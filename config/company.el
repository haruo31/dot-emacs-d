(unless (package-installed-p 'company)
  (package-refresh-contents) (package-install 'company))

;; company-mode
;; (add-hook 'after-init-hook 'global-company-mode)
(global-company-mode 1)
