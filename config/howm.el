(unless (package-installed-p 'howm)
  (package-refresh-contents) (package-install 'howm))

;; howm
(setq howm-menu-lang 'ja)
(global-unset-key "\C-z")
(setq howm-prefix "\C-z") ;; howm のキーを「C-c , □」から「C-z □」に変更
(setq howm-view-title-header "*")

(add-hook
 'after-init-hook
 '(lambda ()
    (require 'howm)))
