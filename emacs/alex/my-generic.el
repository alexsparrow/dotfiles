
(tool-bar-mode -1)
(column-number-mode t)
(line-number-mode t)
(setq inhibit-startup-message t)
(show-paren-mode t)
(setq x-select-enable-clipboard t)
(setq visible-bell t)
(setq use-file-dialog nil)
(setq use-dialog-box nil)
(blink-cursor-mode 1)
(transient-mark-mode t)
(set-default 'indicate-empty-lines t)
(set-default 'fill-column 80)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
;(toggle-scroll-bar -1)
(scroll-bar-mode -1)

;; Trailing whitespace is unnecessary
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

(require 'color-theme)
(color-theme-initialize)

(color-theme-dark-laptop)
;(color-theme-lethe)
(require 'column-marker)

(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)

(require 'multi-term)
(setq multi-term-program "/bin/bash")

(setq-default kill-read-only-ok t)

(require 'pretty-mode)

;; Don't truncate lines
(setq truncate-lines t)
(setq truncate-partial-width-windows nil)

(setq user-full-name "Alex Sparrow"
      mail-from-style 'angles
      user-mail-address "alex.sparrow@cern.ch"
      mail-default-reply-to user-mail-address)

(setq browse-url-browser-function 'browse-url-firefox
      browse-url-new-window-flag t
      browse-url-firefox-new-window-is-tab t)

;; Custom scrolling from emacs-fu
(setq
  scroll-margin 0
  scroll-conservatively 100000
  scroll-preserve-screen-position 1)

(winner-mode 1)
