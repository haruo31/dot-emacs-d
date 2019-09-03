(check-and-install-package 'org 'ob-rust 'htmlize 'ansi-color)

(require 'org)
(add-hook 'org-mode-hook 'howm-mode)
(setq howm-file-name-format "%Y/%m/%Y_%m_%d.howm")
(add-to-list 'auto-mode-alist '("\\.howm$" . org-mode))
(setq org-return-follows-link t
      org-src-fontify-natively t
      org-confirm-babel-evaluate nil)

(defun org-insert-source-block ()
  (interactive)
  (insert "#+begin_src \n\n#+end_src\n"))

;; org-mode babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((C . t)
   (R . t)
   (calc . t)
   (ditaa . t)
   (dot . t)
   (java . t)
   (ledger . t)
   (python . t)
   (rust . t)
   (scala . t)
   (shell . t)))

(require 'ansi-color)
(defun display-ansi-colors ()
  (interactive)
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))
