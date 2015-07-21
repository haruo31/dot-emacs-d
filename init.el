(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(current-language-environment "UTF-8")
 '(custom-enabled-themes (quote (wombat)))
 '(dynamic-fonts-set-monospace-faces (quote (default)))
 '(dynamic-fonts-set-proportional-faces (quote (default)))
 '(eclim-eclipse-dirs (quote ("~/app/eclipse")))
 '(tool-bar-mode nil))

(defun load-directory (directory)
  "Load recursively all `.el' files in DIRECTORY."
  (dolist (element (directory-files-and-attributes directory nil nil nil))
    (let* ((path (car element))
           (fullpath (concat directory "/" path))
           (isdir (car (cdr element)))
           (ignore-dir (or (string= path ".") (string= path ".."))))
      (cond
       ((and (eq isdir t) (not ignore-dir))
        (load-directory fullpath))
       ((and (eq isdir nil) (string= (substring path -3) ".el"))
        (load (file-name-sans-extension fullpath)))))))

(global-linum-mode t)
(setq linum-format "%d ")

;; display current line
(global-hl-line-mode 1)
;;(set-face-attribute hl-line-face nil :underline t)
(setq hl-line-face 'underline)

;; tab
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(electric-indent-mode 0)



;;parenthesis
(show-paren-mode t)

(add-hook 'before-save-hook
          'delete-trailing-whitespace)

;; turn off auto save and auto backup
(setq make-backup-files nil)
(setq auto-save-default nil)
;; (setq create-lockfiles nil)

(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(load-directory "~/.emacs.d/config")
