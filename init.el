

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(current-language-environment "UTF-8")
 '(custom-enabled-themes (quote (wheatgrass)))
 '(package-selected-packages
   (quote
    (toml racer rust-mode ob-rust mu4e-maildirs-extension org-mu4e howm helm-flycheck helm-git helm-git-files helm-git-grep helm-ls-git helm-mu helm-pydoc groovy-mode wanderlust yaml-mode web-mode vbasense tide semi php-mode mmm-mode markdown-mode helm-gtags ggtags flycheck-pos-tip ensime ddskk company-anaconda)))
 '(safe-local-variable-values
   (quote
    ((eval setq flycheck-clang-include-path
           (list "/Library/Java/JavaVirtualMachines/jdk1.8.0_152.jdk/Contents/Home/include" "/Library/Java/JavaVirtualMachines/jdk1.8.0_152.jdk/Contents/Home/include/linux"))
     (flycheck-clang-include-path "/Library/Java/JavaVirtualMachines/jdk1.8.0_152.jdk/Contents/Home/include")
     (company-clang-arguments "-I/Library/Java/JavaVirtualMachines/jdk1.8.0_152.jdk/Contents/Home/include"))))
 '(tool-bar-mode nil))

;; utility functions

(defun load-if-exists (el)
  (if (file-exists-p el) (load el)))



;; tab
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(electric-indent-mode 0)

(setq make-backup-files nil
      auto-save-default nil)

;; parenthesis
;; http://emacs.rubikitch.com/show-paren-local-mode/
(show-paren-mode t)

;; delete whitespace before save
(add-hook 'before-save-hook
          'delete-trailing-whitespace)


(load-if-exists "~/.emacs.d/private.el")

;; package manager
;; enabling MELPA
;; https://www-he.scphys.kyoto-u.ac.jp/member/shotakaha/dokuwiki/doku.php?id=toolbox:emacs:package:start
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(defun check-and-install-package (&rest packages)
  (dolist (pkg packages)
    (unless (package-installed-p pkg)
      (package-refresh-contents) (package-install pkg))))

;; on update packages
;; execute: M-x package-list-packages
;; and type U and x

;; load config/ directory
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

(load-directory "~/.emacs.d/config")

(load-if-exists "~/.emacs.d/mu4e.private.el")
