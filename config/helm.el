(unless (package-installed-p 'helm)
  (package-refresh-contents) (package-install 'helm))

(require 'helm-mode)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
