(unless (package-installed-p 'ddskk)
  (package-refresh-contents) (package-install 'ddskk))

(autoload 'skk-mode "skk" nil t)
(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-auto-fill-mode)

(if (file-exists-p "~/.emacs.d/SKK-JISYO.L")
    (setq skk-large-jisyo "~/.emacs.d/SKK-JISYO.L"))
