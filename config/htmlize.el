(unless (package-installed-p 'htmlize)
  (package-refresh-contents) (package-install 'htmlize))

(setq-default htmlize-output-type "inline-css")
(require 'htmlize)
