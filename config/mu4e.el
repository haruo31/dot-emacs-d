
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
(setenv "XAPIAN_CJK_NGRAM" "true")

(require 'mu4e)
(require 'org-mu4e)
(require 'mu4e-maildirs-extension)

(setq url-proxy-services
      '(("http" . "127.0.0.1:3128")
        ("https" . "127.0.0.1:3128")))

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

(defun my-mu4e-refile-classes (msg)
  (let ((ml (or (mu4e-message-field msg :mailing-list) ""))
        (subject (mu4e-message-field msg :subject))
        (maildir (mu4e-message-field msg :maildir)))
    (cond
     ((not (string-match-p "/inbox" maildir)) maildir)
     ((string-match-p "JYJ-cafe" ml)
      "/archive")
     ((string-match-p "Jenkins" subject)
      "/jenkins")
     ;; messages to the cluster-users
     ((string-match-p "nlp-login\\|jgn-users\\|mcc-user\\|khnw-user\\|rec-user"
                      ml)
      "/cluster-user")
     ((and
       (string-match-p "レポート" subject)
       (mu4e-message-contact-field-matches msg :from "haruo31@nict.go.jp"))
      "/report")
     (t "/inbox") ;; default
     )))

(setq mu4e-refile-folder 'my-mu4e-refile-classes)

(add-to-list 'mu4e-marks
  '(archive
     :char       ("f" . "🤘")
     :prompt     "finished"
     :dyn-target (lambda (target msg)
                   (let ((dest (my-mu4e-refile-classes msg)))
                     (if (string= "/inbox" dest) "/archive" dest)))
     :action      (lambda (docid msg target)
                      (mu4e~proc-move docid
                                      (mu4e~mark-check-target target)
                                      "+S-u-N"))))

(mu4e~headers-defun-mark-for archive)
(define-key mu4e-headers-mode-map (kbd "f") 'mu4e-headers-mark-for-archive)

(mu4e-maildirs-extension)
