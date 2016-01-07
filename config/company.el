(unless (package-installed-p 'company)
  (package-refresh-contents) (package-install 'company))
(unless (package-installed-p 'company-anaconda)
  (package-refresh-contents) (package-install 'company-anaconda))

;; company-mode
;; (add-hook 'after-init-hook 'global-company-mode)
(global-company-mode 1)

(eval-after-load "company"
 '(progn
   (add-to-list 'company-backends 'company-anaconda)))
(add-hook 'python-mode-hook 'anaconda-mode)
