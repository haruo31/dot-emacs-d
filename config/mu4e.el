
(check-and-install-package 'mu4e-maildirs-extension)
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu/mu4e")
(setenv "XAPIAN_CJK_NGRAM" "true")

(require 'mu4e)
(require 'org-mu4e)
(require 'mu4e-maildirs-extension)

(setq mu4e-mu-binary "/usr/local/bin/mu"
      mu4e-get-mail-command "getmail"
      mu4e-headers-results-limit 2048
      mu4e-headers-include-related t
      mu4e-headers-skip-duplicates t
      mu4e-update-interval 300
      mu4e-use-fancy-chars t
      mu4e-view-show-images t
      mu4e-index-cleanup t
      mu4e-index-lazy-check t
      mu4e-cache-maildir-list t
      org-mu4e-link-query-in-headers-mode t
      )

(add-to-list 'mu4e-bookmarks
             '("maildir:/inbox date:7d..now"
               "Inbox"
               ?i))

(add-to-list 'mu4e-bookmarks
             '("flag:flagged"
               "Flagged messages"
               ?f))
