(check-and-install-package 'company 'company-anaconda)

;; enable anaconda mode
(eval-after-load "company"
  '(progn
     (global-company-mode 1)
     (add-to-list 'company-backends 'company-anaconda)
     (add-hook 'python-mode-hook 'anaconda-mode)))
