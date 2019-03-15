;;; Code: utf8

(add-hook
 'after-init-hook
 '(lambda ()
    (if (eq system-type 'darwin)
(progn
(set-fontset-font t 'unicode "Symbola" nil 'prepend)
)

      (when window-system
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default
    ((t (:inherit nil
                  :stipple nil
                  :background "black"
                  :foreground "wheat"
                  :inverse-video nil
                  :box nil
                  :strike-through nil
                  :overline nil
                  :underline nil
                  :slant normal
                  :weight normal
                  :height 105
                  :width normal
                  :foundry "PfEd"
                  :family "Noto Sans Mono")))))))))
