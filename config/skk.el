(check-and-install-package 'ddskk)

(autoload 'skk-mode "skk" nil t)

(add-hook
 'after-init-hook
 '(lambda ()
    (progn
      (setq default-input-method "japanese-skk")
      (if (file-exists-p "~/.emacs.d/SKK-JISYO.L")
        (setq skk-large-jisyo "~/.emacs.d/SKK-JISYO.L")))))
