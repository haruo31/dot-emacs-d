(unless (package-installed-p 'skk-vars)
  (package-refresh-contents) (package-install 'ddskk))

(require 'skk-vars)
(global-set-key "\C-x\C-j" 'skk-mode)
(autoload 'skk-mode "skk" nil t)
