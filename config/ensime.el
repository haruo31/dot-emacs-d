(check-and-install-package 'ensime)

;; ensime
;; https://www.ncaq.net/2018/05/18/16/15/50/
(eval-after-load "ensime"
  '(progn
     (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
     (setq ensime-sem-high-faces
           '((var . (:foreground "#ff2222"))
             (val . (:foreground "#dddddd"))
             (varField . (:foreground "#ff3333"))
             (valField . (:foreground "#dddddd"))
             (functionCall . (:foreground "#84BEE3"))
             (param . (:foreground "#ffffff"))
             (class . font-lock-type-face)
             (trait . (:foreground "#084EA8"))
             (object . (:foreground "#026DF7"))
             (package . font-lock-preprocessor-face)))))
