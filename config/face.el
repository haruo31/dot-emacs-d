;;; Code: utf8

(add-hook
 'after-init-hook
 '(lambda ()
    (if (eq system-type 'darwin)
        (progn
          (cond
           ;; Cocoa Emacs
           ((and (eq window-system 'ns)
                 (or (and (= emacs-major-version 23) (>= emacs-minor-version 3))
                     (= emacs-major-version 24)))
            ;; Cocoa Emacs のフォント設定について - 瀬戸亮平
            ;; http://d.hatena.ne.jp/setoryohei/20110117/1295336454
            (let* ((size 12) ; ASCIIフォントのサイズ [9/10/12/14/15/17/19/20/...]
                   (asciifont "Menlo") ; ASCIIフォント
                   (jpfont "Hiragino Maru Gothic Pro") ;; 日本語フォント
                   (h (* size 10))
                   (fontspec (font-spec :family asciifont))
                   (jp-fontspec (font-spec :family jpfont))
                   (osaka-fontspec (font-spec :family "Osaka")))
              (set-face-attribute 'default nil :family asciifont :height h)
              (set-fontset-font nil 'japanese-jisx0213.2004-1 jp-fontspec)
              (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
              (set-fontset-font nil 'katakana-jisx0201 jp-fontspec) ; 半角カナ
              (set-fontset-font nil '(#x0080 . #x024F) fontspec) ; 分音符付きラテン
              ;; (set-fontset-font nil '(#x0370 . #x03FF) fontspec) ; ギリシャ文字
              (set-fontset-font nil '(#x0370 . #x03FF) jp-fontspec) ; ギリシャ文字
              (set-fontset-font nil '#xFF0B osaka-fontspec) ; ＋（プラス）
              (set-fontset-font nil '#x2212 osaka-fontspec) ; −（マイナス）
              (set-fontset-font nil '#x00B1 osaka-fontspec) ; ±（プラスマイナス）
              (set-fontset-font nil '#x00D7 osaka-fontspec) ; ×（かける）
              (set-fontset-font nil '#x00F7 osaka-fontspec) ; ÷（わる）
              )

            ;; フォントサイズの比を設定
            (dolist (elt '(("^-apple-hiragino.*" . 1.2)
                           (".*osaka-bold.*" . 1.2)
                           (".*osaka-medium.*" . 1.2)
                           (".*courier-bold-.*-mac-roman" . 1.0)
                           (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
                           (".*monaco-bold-.*-mac-roman" . 0.9)))
              (add-to-list 'face-font-rescale-alist elt))

            ;; 123456789012345678901234567890
            ;; ABCDEFGHIJKLMNOPQRSTUVWXYZabcd
            ;; あいうえおかきくけこさしすせそ
            ;; ◎○●▲■◎○●▲■◎○●▲■
            ;; ×÷±＋−×÷±＋−×÷±＋−
            ;; 123456789012345678901234567890
            ;; ΑΒΓαβγΑΒΓαβγΑΒΓαβγΑΒΓαβγΑΒΓαβγ

            ;; フレームの縦横サイズ・位置
            (cond
             ((equal system-name "kawachoimac.local")
              (add-to-list 'default-frame-alist '(top . 50))
              (add-to-list 'default-frame-alist '(left . 0))
              (add-to-list 'default-frame-alist '(width . 150))
              (add-to-list 'default-frame-alist '(height . 90)))
             (t
              (add-to-list 'default-frame-alist '(width . 100))
              (add-to-list 'default-frame-alist '(height . 50)))))
           ;; Windows, gnupack
           ;; gnupack の ini で設定されているのをそのまま使う。
           ))
      (when window-system
        (progn
          (set-face-attribute 'default nil :family "M+ 1m" :height 100 :weight 'semi-bold)
          (set-fontset-font nil 'japanese-jisx0208 (font-spec :name "M+ 1m"))
      ;;; see: http://rubikitch.com/2015/05/14/global-hl-line-mode-timer/
          (require 'hl-line)
          (defun global-hl-line-timer-function ()
            (global-hl-line-unhighlight-all)
            (let ((global-hl-line-mode t))
              (global-hl-line-highlight)))
          (setq global-hl-line-timer
                (run-with-idle-timer 0.03 t 'global-hl-line-timer-function))
          (set-face-background hl-line-face "gray14"))))
    (add-to-list 'default-frame-alist '(height . 32))
    (add-to-list 'default-frame-alist '(width . 80))))
;;;
