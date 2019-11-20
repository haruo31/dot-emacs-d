
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(load custom-file t)
(load "~/.emacs.d/private.el" t)

(require 'package)
(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

(unless (require 'use-package nil t)
  (progn (package-refresh-contents)
         (package-install 'use-package)
         (require 'use-package)))

;;;;;; key configuration

;; tab
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(electric-indent-mode 0)

(setq make-backup-files nil
      viper-mode nil
      auto-save-default t)

;;;;;; input method

(use-package skk
  :ensure ddskk
  :config
  (setq default-input-method "japanese-skk")
  (setq skk-preload t)
  (if (file-exists-p "~/.emacs.d/SKK-JISYO.L")
      (setq skk-large-jisyo "~/.emacs.d/SKK-JISYO.L")))

;;;;;; journal

(use-package org
  :ensure t
  :config
  (setq org-return-follows-link t
        org-src-fontify-natively t
        org-confirm-babel-evaluate nil))

(use-package org-journal
  :ensure t
  :after org
  :custom
  (org-journal-dir "~/howm/")
  (org-journal-file-format "%Y/%m/%Y%m%d.howm")
  (org-journal-date-format "%Y-%m-%d")
  :config
  (setq org-journal-enable-agenda-integration t
        org-icalendar-store-UID t
        org-icalendar-include-todo "all"
        org-icalendar-combined-agenda-file "~/howm/org-journal.ics"
        org-agenda-file-regexp "\\`\\\([^.].*\\.\\\(org\\\|howm\\\)\\\|[0-9]\\\{8\\\}\\\(\\.gpg\\\)?\\\)\\'")
  (add-to-list 'org-agenda-files org-journal-dir))

;;;;;; pinentry

(use-package pinentry
  :ensure t
  :config
  (pinentry-start))

;;;;;; helm

(use-package helm-config
  :ensure helm
  :bind
  (("M-x" . helm-M-x)
   ("C-x C-f" . helm-find-files)
   ("C-x b" . helm-buffers-list))
  :config
  (helm-mode 1))

;;;;;; email

(load "~/.emacs.d/mu4e.private.el" t)

(use-package bbdb
  :ensure t
  :config
  (bbdb-initialize 'message))

;;;;;; look and feels

(add-hook
 'after-init-hook
 '(lambda ()
    (progn
      (custom-set-variables
       '(max-mini-window-height 3)
       '(tool-bar-mode nil)
       '(current-language-environment "UTF-8")
       '(show-paren-mode t))
      (if (eq system-type 'darwin)
          (set-fontset-font t 'unicode "Symbola" nil 'prepend)
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
                            :family "Noto Sans Mono"))))))))))

(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-dracula t))

(use-package all-the-icons
  :ensure t)

(use-package doom-modeline
  :ensure t
  :after all-the-icons
  :config
  (doom-modeline-mode 1)
  (display-time-mode 1))

;;;;;; development

(use-package diff-hl
  :ensure t
  :config
  (global-diff-hl-mode 1))

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

(use-package projectile
  :ensure t
  :bind
  (:map projectile-mode-map
        ("C-c p" . projectile-command-map))
  :config
  (projectile-mode 1))

(use-package flymake
  :ensure t
  :bind
  (:map flymake-mode-map
        (("M-n" . flymake-goto-next-error)
         ("M-p" . flymake-goto-prev-error)))
  :hook
  (elisp-mode . flymake-mode)
  :config
  (setq flymake-no-changes-timeout 0.2))

(use-package helm-flymake
  :after (helm flymake)
  :custom
  (flymake-cursor-error-display-delay 0.4)
  (flymake-cursor-number-of-errors-to-display 3)
  :config
  (flymake-cursor-mode))

(use-package company
  :ensure t
  :hook
  (after-init . global-company-mode)
  :bind
  (("M-/" . company-complete))
  :config
  (lambda () t))

;;;;;; jedi python mode

(use-package jedi-core
  :ensure company-jedi
  :after company
  :hook
  (python-mode . jedi:setup)
  :config
  (setq jedi:complete-on-dot t)
  (setq jedi:use-shortcuts t)
  (add-to-list 'company-backends 'company-jedi))

;;;;;; c family cpp objc

(use-package irony
  :ensure t
  :hook
  ((c-mode irony-mode)
   (c++-mode irony-mode)
   (objc-mode irony-mode)
   (irony-mode irony-cdb-autosetup-compile-options))
  :config
  (setq irony-lang-compile-option-alist
        '((c++-mode . ("c++" "-std=c++11" "-lstdc++" "-lm"))
          (c-mode . ("c"))
          (objc-mode . '("objective-c"))))
  (defun irony--lang-compile-option ()
    (irony--awhen (cdr-safe (assq major-mode irony-lang-compile-option-alist))
      (append '("-x") it))))

(use-package company-irony
  :ensure t
  :after (company irony)
  :config
  (add-to-list 'company-backends 'company-irony))

;;;;;; nxml html modes

(use-package nxml-mode)

;;;; delete whitespace before save
;;(add-hook 'before-save-hook
;;          'delete-trailing-whitespace)
