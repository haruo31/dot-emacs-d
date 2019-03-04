(check-and-install-package 'ggtags)

;;; https://github.com/leoliu/ggtags
;;; http://blog.10rane.com/2014/09/17/to-reading-comprehension-of-the-source-code-by-introducing-the-helm-gtags-mode/

(add-hook 'c-mode-common-hook
           (lambda ()
             (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
               (ggtags-mode 1))))

;;;
