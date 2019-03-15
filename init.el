

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
    (org-mu4e howm helm-flycheck helm-git helm-git-files helm-git-grep helm-ls-git helm-mu helm-pydoc groovy-mode wanderlust yaml-mode web-mode vbasense tide semi php-mode mmm-mode markdown-mode htmlize helm-gtags ggtags flycheck-pos-tip ensime ddskk company-anaconda)))
 '(safe-local-variable-values
   (quote
    ((eval setq flycheck-clang-include-path
           (list "/Library/Java/JavaVirtualMachines/jdk1.8.0_152.jdk/Contents/Home/include" "/Library/Java/JavaVirtualMachines/jdk1.8.0_152.jdk/Contents/Home/include/linux"))
     (flycheck-clang-include-path "/Library/Java/JavaVirtualMachines/jdk1.8.0_152.jdk/Contents/Home/include")
     (company-clang-arguments "-I/Library/Java/JavaVirtualMachines/jdk1.8.0_152.jdk/Contents/Home/include"))))
 '(tool-bar-mode nil))

;; tab
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(electric-indent-mode 0)

;; (add-to-list 'load-path "~/.emacs.d/el-get/el-get")

;;parenthesis
(show-paren-mode t)

(add-hook 'before-save-hook
          'delete-trailing-whitespace)

;; turn off auto save and auto backup
(setq make-backup-files nil)
(setq auto-save-default nil)
;; (setq create-lockfiles nil)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; (unless (require 'el-get nil 'noerror)
;;   (add-to-list 'package-archives
;;                '("melpa" . "http://melpa.org/packages/"))
;;   (package-refresh-contents)
;;   (package-initialize)
;;   (package-install 'el-get)
;;   (require 'el-get))

;; (add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
;; (el-get 'sync)

;;; local functions

;;; package auto fetch
(defun check-and-package-install (title)
  (unless (package-installed-p title)
    (package-refresh-contents) (package-install title)))


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

(if (file-exists-p "~/.emacs.d/private.el")
    (load "~/.emacs.d/private.el"))

(load-directory "~/.emacs.d/config")
