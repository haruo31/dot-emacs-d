(check-and-install-package 'ddskk)

(require 'skk)

(add-hook
 'after-init-hook
 '(lambda ()
    (progn
      (setq default-input-method "japanese-skk")
      (setq skk-isearch-mode-enable 'always)
      (setq skk-isearch-start-mode 'latin)
      (setq skk-preload t)
      (if (file-exists-p "~/.emacs.d/SKK-JISYO.L")
        (setq skk-large-jisyo "~/.emacs.d/SKK-JISYO.L")))))
