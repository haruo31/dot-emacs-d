(unless (package-installed-p 'mmm-mode)
  (package-refresh-contents) (package-install 'mmm-mode))

(add-hook
 'after-init-hook
 (progn
   (require 'mmm-mode)))
