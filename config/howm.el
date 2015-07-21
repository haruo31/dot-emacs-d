(add-to-list 'load-path "~/.emacs.d/mypkg/howm")
;; howm
(require 'howm)
(setq howm-menu-lang 'ja)
(global-set-key "\C-c,," 'howm-menu)
