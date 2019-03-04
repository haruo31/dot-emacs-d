(check-and-install-package 'helm 'helm-gtags)

(add-hook
 'after-init-hook
 '(lambda ()
    (progn
      (require 'helm-mode)
      (global-set-key (kbd "M-x") 'helm-M-x)
      (global-set-key (kbd "C-x C-f") 'helm-find-files)
      (require 'helm-gtags)
      (add-hook 'dired-mode-hook 'helm-gtags-mode)
      (add-hook 'eshell-mode-hook 'helm-gtags-mode)
      (add-hook 'c-mode-hook 'helm-gtags-mode)
      (add-hook 'c++-mode-hook 'helm-gtags-mode)
      (add-hook 'asm-mode-hook 'helm-gtags-mode))))
