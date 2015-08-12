(unless (package-installed-p 'skk-vars)
  (package-refresh-contents) (package-install 'ddskk))

(require 'skk-vars)
(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-auto-fill-mode)
(autoload 'skk-mode "skk" nil t)

(if (file-exists-p "~/.emacs.d/SKK-JISYO.L")
    (setq skk-large-jisyo "~/.emacs.d/SKK-JISYO.L"))
