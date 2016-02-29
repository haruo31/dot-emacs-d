(unless (package-installed-p 'htmlize)
  (package-refresh-contents) (package-install 'htmlize))

(add-hook
 'after-init-hook
 '(lambda ()
    (progn
      (setq-default htmlize-output-type "inline-css")
      (require 'htmlize))))
