(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs-lisp/vendor/yasnippet-0.6.0c/snippets")
(setq yas/root-directory "~/.emacs-lisp/alex/snippets")
(yas/load-directory yas/root-directory)
