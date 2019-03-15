(unless (package-installed-p 'exec-path-from-shell)
  (package-refresh-contents) (package-install 'exec-path-from-shell))

(exec-path-from-shell-initialize)
