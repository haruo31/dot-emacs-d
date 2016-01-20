(require 'ps-print)
(setq ps-paper-type        'a4 ;paper size
      ps-lpr-command       "lpr"
      ps-lpr-switches      '("-o Duplex=DuplexNoTumble")
      ps-multibyte-buffer  'non-latin-printer ;for printing Japanese
      ps-n-up-printing     1 ;print n-page per 1 paper

      ;; Margin
      ps-left-margin       20
      ps-right-margin      20
      ps-top-margin        20
      ps-bottom-margin     20
      ps-n-up-margin       20

      ;; Header/Footer setup
      ps-print-header      t        ;buffer name, page number, etc.
      ps-print-footer      nil          ;page number

      ;; font
      ps-font-size         '(9 . 10)
      ps-header-font-size  '(10 . 12)
      ps-header-title-font-size '(12 . 14)
      ps-header-font-family 'Helvetica    ;default
      ps-line-number-font  "Times-Italic" ;default
      ps-line-number-font-size 6

      ;; line-number
      ;; ps-line-number       t ; t:print line number
      ;; ps-line-number-start 1
      ;; ps-line-number-step  1
      )

(when (executable-find "ps2pdf")
  (defun modi/pdf-print-buffer-with-faces (&optional filename)
    "Print file in the current buffer as pdf, including font, color, and
underline information.  This command works only if you are using a window system,
so it has a way to determine color values.

C-u COMMAND prompts user where to save the Postscript file (which is then
converted to PDF at the same location."
    (interactive (list (if current-prefix-arg
                           (ps-print-preprint 4)
                         (concat (file-name-sans-extension (buffer-file-name))
                                 ".ps"))))
    (ps-print-with-faces (point-min) (point-max) filename)
    (shell-command (concat (executable-find "ps2pdf") " " filename))
    (delete-file filename)
    (message "Deleted %s" filename)
    (message "Wrote %s" (concat (file-name-sans-extension filename) ".pdf"))))
