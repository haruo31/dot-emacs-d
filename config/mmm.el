(unless (package-installed-p 'mmm-mode)
  (package-refresh-contents) (package-install 'mmm-mode))

(require 'mmm-mode)
