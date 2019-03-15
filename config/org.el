(unless (package-installed-p 'org)
  (package-refresh-contents) (package-install 'org))

(require 'org)
(add-hook 'org-mode-hook 'howm-mode)
(setq howm-file-name-format "%Y/%m/%Y_%m_%d.howm")
(add-to-list 'auto-mode-alist '("\\.howm$" . org-mode))

(defun org-insert-source-block ()
  (interactive)
  (insert "#+begin_src \n\n#+end_src\n"))

;; org-mode babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (shell . t)
   (java . t)
   (scala . t)
   (calc . t)
   (ledger . t)
   ))

(setq org-src-fontify-natively t)
