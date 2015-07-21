
(add-to-list 'default-frame-alist '(height . 32))
(add-to-list 'default-frame-alist '(width . 146))

(set-face-attribute 'default nil :family "M+ 2m" :height 100 :weight 'semi-bold)
(set-fontset-font nil 'japanese-jisx0208 (font-spec :name "M+ 2m"))

;; tab setting
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
                        64 68 72 76 80 84 88 92 96 100 104 108 112
                        116 120))
