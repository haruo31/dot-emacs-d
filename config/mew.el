;;(add-to-list 'load-path "~/.emacs.d/mypkg/Mew")
;;;; run configure and make in Mew/bin
;;
;;(add-hook
;; 'after-init-hook
;; '(lambda ()
;;    (progn
;;      ;; mew
;;      (require 'mew)
;;      (autoload 'mew-send "mew" nil t)
;;
;;      (setq exec-path (cons "~/.emacs.d/mypkg/Mew/bin" exec-path))
;;
;;      ;; Optional setup (Read Mail menu):
;;      (setq read-mail-command 'mew)
;;
;;      ;; Optional setup (e.g. C-xm for sending a message):
;;      (autoload 'mew-user-agent-compose "mew" nil t)
;;      (if (boundp 'mail-user-agent)
;;          (setq mail-user-agent 'mew-user-agent))
;;      (if (fboundp 'define-mail-user-agent)
;;          (define-mail-user-agent
;;            'mew-user-agent
;;            'mew-user-agent-compose
;;            'mew-draft-send-message
;;            'mew-draft-kill
;;            'mew-send-hook)))))
;;
