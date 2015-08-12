(add-to-list 'load-path "~/.emacs.d/mypkg/howm")
;; howm
(setq howm-menu-lang 'ja)
(global-unset-key "\C-z")
(setq howm-prefix "\C-z") ;; howm のキーを「C-c , □」から「C-z □」に変更
(setq howm-view-title-header "*")

(require 'howm)
