
(if (file-exists-p "/usr/local/share/emacs/site-lisp/mu/mu4e")
    (progn
      (check-and-install-package 'mu4e-maildirs-extension 'cp5022x 'shr 'pinentry)
      (add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu/mu4e")
      (setenv "XAPIAN_CJK_NGRAM" "true")

      ;; preventing mis-decoding emails problem
      ;; https://uwabami.github.io/cc-env/Emacs.html

      (require 'mu4e)
      (require 'epg)
      (require 'epg-config)
      (require 'mml2015)
      (require 'org-mu4e)
      (require 'mu4e-maildirs-extension)

      (require 'epa)

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
            mu4e-html2text-command
            (if (executable-find "w3m")
                "w3m -dump -T text/html -cols 72 -o display_link_number=true -o display_image=false -o ignore_null_img_alt=true"
              (if (executable-find "html2text")
                  "html2text -utf8 -width 72"
                mu4e-html2text-command))
            org-mu4e-link-query-in-headers-mode t

            epa-pinentry-mode 'loopback
            mu4e-compose-signature-auto-include t
            mm-decrypt-option 'always
            mm-verify-option 'always
            mml2015-use 'epg
            )

      (add-hook 'mu4e-compose-mode-hook
                (defun my-mu4e-auto-sign ()
                  (mml-secure-message-sign-pgpmime)))


      (add-to-list 'mu4e-bookmarks
                   '("maildir:/inbox date:7d..now"
                     "Inbox"
                     ?i))

      (add-to-list 'mu4e-bookmarks
                   '("flag:flagged"
                     "Flagged messages"
                     ?f))

      (pinentry-start)
      ))
