
(check-and-install-package 'doom-modeline 'all-the-icons 'doom-themes)

(require 'doom-themes)

(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)
(load-theme 'doom-dracula t)

(require 'all-the-icons)
(require 'doom-modeline)
(doom-modeline-mode 1)
(display-time-mode 1)
