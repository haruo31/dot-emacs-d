(unless (package-installed-p 'ggtags)
  (package-refresh-contents) (package-install 'ggtags))

(add-hook 'c-mode-common-hook
           (lambda ()
             (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
               (ggtags-mode 1))))

;;;
