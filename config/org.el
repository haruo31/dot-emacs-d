(check-and-install-package 'org 'org-journal 'ob-rust 'htmlize 'ansi-color)

(require 'org)
(require 'org-journal)
(require 'ansi-color)

(add-to-list 'auto-mode-alist '("\\.howm$" . org-mode))
(setq org-return-follows-link t
      org-src-fontify-natively t
      org-confirm-babel-evaluate nil)

(setq org-journal-dir "~/org/journal"
      org-journal-date-format "%A, %d %B %Y")

(setq org-agenda-file-regexp "\\`\\\([^.].*\\.org\\\|[0-9]\\\{8\\\}\\\(\\.gpg\\\)?\\\)\\'")
(add-to-list 'org-agenda-files org-journal-dir)

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
