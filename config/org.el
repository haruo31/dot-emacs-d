(unless (package-installed-p 'org)
  (package-refresh-contents) (package-install 'org))

(require 'org)
(add-hook 'org-mode-hook 'howm-mode)
(setq howm-file-name-format "%Y/%m/%Y_%m_%d.howm")
(add-to-list 'auto-mode-alist '("\\.howm$" . org-mode))

;; org-mode babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))
