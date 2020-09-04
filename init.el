;;;;;; path for command executable
;;;;;; see: http://sakito.jp/emacs/emacsshell.html#path

(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

(load "~/.emacs.d/proxy_setting.el" t)

(eval-and-compile
  (customize-set-variable
   'package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("org"   . "https://orgmode.org/elpa/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf el-get :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init))
  (leaf leaf-convert :ensure t)
  (leaf leaf-tree :ensure t))

(provide 'init)

(leaf cus-edit
  :doc "tools for customizing Emacs and Lisp packages"
  :tag "builtin" "faces" "help"
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))

(leaf cus-start
  :doc "define customization properties of builtins"
  :tag "builtin" "internal"
  :preface
  (defun c/redraw-frame nil
    (interactive)
    (redraw-frame))
  :custom ((create-lockfiles . nil)
           (comp-deferred-compilation . t)
           (viper-mode . nil)
           (debug-on-error . t)
           (init-file-debug . t)
           (frame-resize-pixelwise . t)
           (enable-recursive-minibuffers . t)
           (history-length . 500)
           (history-delete-duplicates . t)
           (ring-bell-function . 'ignore)
           (text-quoting-style . 'straight)
           (message-citation-line-format . "On %a, %b %d %Y, %n wrote:")
           (message-citation-line-function . 'message-insert-formatted-citation-line)
           (show-trailing-whitespace . t)
           (tool-bar-mode . nil)
           (indent-tabs-mode . nil)
           (redisplay-preemption-period . 0.5)))

(leaf add-exec-path
  :config
  (dolist
      (dir (list
            "/sbin"
            "/usr/sbin"
            "/bin"
            "/usr/bin"
            "/opt/local/bin"
            "/sw/bin"
            "/usr/local/bin"
            (expand-file-name "~/bin")
            (expand-file-name "~/.emacs.d/bin")))
    (when (and (file-exists-p dir) (not (member dir exec-path)))
      (setenv "PATH" (concat dir ":" (getenv "PATH")))
      (setenv "XAPIAN_CJK_NGRAM" "1")
      (setenv "LC_ALL" "ja_JP.UTF-8")
      (setq exec-path (append (list dir) exec-path)))))

(leaf ssh-agent-setup
  :config
  (if (file-exists-p (expand-file-name "~/.gnupg/S.gpg-agent.ssh"))
      (setenv "SSH_AUTH_SOCK" (expand-file-name "~/.gnupg/S.gpg-agent.ssh"))))

(leaf paren
      :doc "highlight matching paren"
      :tag "builtin"
      :custom ((show-paren-delay . 0.1))
      :global-minor-mode show-paren-mode)

(leaf files
  :doc "file input and output commands for Emacs"
  :tag "builtin"
  :custom `((auto-save-timeout . 15)
            (auto-save-interval . 60)
            (auto-save-file-name-transforms . '((".*" ,(locate-user-emacs-file "backup/") t)))
            (backup-directory-alist . '((".*" . ,(locate-user-emacs-file "backup"))
                                        (,tramp-file-name-regexp . nil)))
            (version-control . t)
            (delete-old-versions . t)))

(leaf startup
  :doc "process Emacs shell arguments"
  :tag "builtin" "internal"
  :custom `((auto-save-list-file-prefix . ,(locate-user-emacs-file "backup/.saves-"))))

(leaf ivy
  :doc "Incremental Vertical completYon"
  :req "emacs-24.5"
  :tag "matching" "emacs>=24.5"
  :url "https://github.com/abo-abo/swiper"
  :emacs>= 24.5
  :ensure t
  :blackout t
  :leaf-defer nil
  :custom ((ivy-initial-inputs-alist . nil)
           (ivy-re-builders-alist . '((t . ivy--regex-fuzzy)
                                      (swiper . ivy--regex-plus)))
           (ivy-use-selectable-prompt . t)
           (ivy-use-virtual-buffers . t))
  :global-minor-mode t
  :config
  (leaf swiper
    :doc "Isearch with an overview. Oh, man!"
    :req "emacs-24.5" "ivy-0.13.0"
    :tag "matching" "emacs>=24.5"
    :url "https://github.com/abo-abo/swiper"
    :emacs>= 24.5
    :ensure t
    :bind (("C-s" . swiper)))

  (leaf counsel
    :doc "Various completion functions using Ivy"
    :req "emacs-24.5" "swiper-0.13.0"
    :tag "tools" "matching" "convenience" "emacs>=24.5"
    :url "https://github.com/abo-abo/swiper"
    :emacs>= 24.5
    :ensure t
    :blackout t
    :bind (("C-S-s" . counsel-imenu)
           ("C-x C-r" . counsel-recentf))
    :custom `((counsel-yank-pop-separator . "\n----------\n")
              (counsel-find-file-ignore-regexp . ,(rx-to-string '(or "./" "../") 'no-group)))
    :global-minor-mode t))

(leaf ivy-rich
  :doc "More friendly display transformer for ivy."
  :req "emacs-24.5" "ivy-0.8.0"
  :tag "ivy" "emacs>=24.5"
  :emacs>= 24.5
  :ensure t
  :after ivy
  :global-minor-mode t)

;;(leaf prescient
;;  :doc "Better sorting and filtering"
;;  :req "emacs-25.1"
;;  :tag "extensions" "emacs>=25.1"
;;  :url "https://github.com/raxod502/prescient.el"
;;  :emacs>= 25.1
;;  :ensure t
;;  :commands (prescient-persist-mode)
;;  :custom `((prescient-aggressive-file-save . t)
;;            (prescient-save-file . ,(locate-user-emacs-file "prescient")))
;;  :global-minor-mode prescient-persist-mode)
;;
;;(leaf ivy-prescient
;;  :doc "prescient.el + Ivy"
;;  :req "emacs-25.1" "prescient-4.0" "ivy-0.11.0"
;;  :tag "extensions" "emacs>=25.1"
;;  :url "https://github.com/raxod502/prescient.el"
;;  :emacs>= 25.1
;;  :ensure t
;;  :after prescient ivy
;;  :custom ((ivy-prescient-retain-classic-highlighting . t))
;;  :global-minor-mode t)

(leaf autorevert
  :doc "revert buffers when files on disk change"
  :tag "builtin"
  :custom ((auto-revert-interval . 5)
           (auto-revert-check-vc-info . t))
  :global-minor-mode global-auto-revert-mode)

(leaf flycheck
  :doc "On-the-fly syntax checking"
  :req "dash-2.12.1" "pkg-info-0.4" "let-alist-1.0.4" "seq-1.11" "emacs-24.3"
  :tag "minor-mode" "tools" "languages" "convenience" "emacs>=24.3"
  :url "http://www.flycheck.org"
  :emacs>= 24.3
  :ensure t
  :bind (("M-n" . flycheck-next-error)
         ("M-p" . flycheck-previous-error))
  :global-minor-mode global-flycheck-mode)

(leaf projectile
  :ensure t
  :bind (("C-c p" . projectile-command-map))
  :global-minor-mode projectile-mode
  :config
  (setq projectile-project-search-path '("~/sources/")))

(leaf elpy
  :ensure t
  :custom ((elpy-rpc-python-command . "python3")
           (elpy-rpc-virtualenv-path . "~/.emacs.d/elpy/rpc-venv")
           (python-shell-interpreter . "python3"))
  :config
  (advice-add 'python-mode :before 'elpy-enable))

(leaf company
  :ensure t
  :global-minor-mode global-company-mode)

;;;;;; input method

(leaf skk
  :doc "SKK mode"
  :ensure ddskk
  :custom ((default-input-method . "japanese-skk"))
  :config
  (if (file-exists-p "~/.emacs.d/SKK-JISYO.L")
      (setq skk-large-jisyo "~/.emacs.d/SKK-JISYO.L")))

;;;;;; journal

(leaf org
  :ensure t
  :config
  (setq org-return-follows-link t
        org-src-fontify-natively t
        org-confirm-babel-evaluate nil)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((shell . t)
     (python . t)
     (perl . t)))
  (leaf org-tempo
    :require t)
  (leaf org-journal
    :ensure t
    :after org
    :require t
    :custom ((org-journal-dir . "~/howm/")
             (org-journal-file-format . "%Y/%m/%Y%m%d.howm")
             (org-journal-date-format . "%Y-%m-%d"))
    :config
    (setq org-journal-enable-agenda-integration t
          org-icalendar-store-UID t
          org-icalendar-include-todo "all"
          org-icalendar-combined-agenda-file "~/howm/org-journal.ics"
          org-agenda-file-regexp "\\`\\\([^.].*\\.\\\(org\\\|howm\\\)\\\|[0-9]\\\{8\\\}\\\(\\.gpg\\\)?\\\)\\'")
    (add-to-list 'org-agenda-files org-journal-dir)))

;;;;;; pinentry

(leaf pinentry
  :ensure t
  :config
  (pinentry-start))

;;;;;; email

(leaf bbdb
  :ensure t
  :config
  (bbdb-initialize 'message))

(load "~/.emacs.d/private.el" t)
(load "~/.emacs.d/mu4e.private.el" t)

;;;;;; look and feels

(leaf doom-themes
  :ensure t
  :require t
  :custom ((doom-themes-enable-bold . t)
           (doom-themes-enable-italic . t))
  :config
  (load-theme 'doom-dracula t)
  (leaf all-the-icons
    :ensure t
    :require t
    :after doom-themes)
  (leaf doom-modeline
    :ensure t
    :after all-the-icons
    :require t
    :global-minor-mode doom-modeline-mode))

;;;;;; development

(leaf diff-hl
      :ensure t
      :global-minor-mode global-diff-hl-mode)

(leaf yasnippet
      :ensure t
      :global-minor-mode yas-global-mode)

;;;;;; nxml html modes

;;;;;; tramp mode

(leaf tramp
  :ensure t)

(leaf yaml-mode
  :ensure t)

(leaf groovy-mode
  :ensure t)

(leaf dockerfile-mode
  :ensure t)

;; Local Variables:
;; indent-tabs-mode: nil
;; End:

;;; init.el ends here
