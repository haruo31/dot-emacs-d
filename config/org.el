(unless (package-installed-p 'org)
  (package-refresh-contents) (package-install 'org))

(require 'org)
(require 'org-tempo)
(add-hook 'org-mode-hook 'howm-mode)
(setq howm-file-name-format "%Y/%m/%Y_%m_%d.howm")
(add-to-list 'auto-mode-alist '("\\.howm$" . org-mode))
(setq org-return-follows-link t
      org-confirm-babel-evaluate nil)

;; org-mode babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (calc . t)
   (C . t)
   (dot . t)
   (shell . t)
   (R . t)
   (rust . t)))
