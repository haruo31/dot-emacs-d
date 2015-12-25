(unless (package-installed-p 'vbasense)
  (package-refresh-contents) (package-install 'vbasense))

(require 'vbasense)

(add-to-list 'load-path "~/.emacs.d/mypkg/visual-basic-mode")
;; howm
;; (require 'visual-basic-mode)
