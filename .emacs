; Emacs Load Path
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "~/.alexdot/emacs/")
	   (default-directory my-lisp-dir))
      (setq load-path (cons my-lisp-dir load-path))
      (normal-top-level-add-subdirs-to-load-path)))

; Start server
(server-start)
(load "my-org")
(load "my-generic")
(load "my-uniquify")
(load "my-defun")
(load "my-gnus")
(load "my-python")
(load "my-vala")

(load "auctex.el" nil t t)
     (load "preview-latex.el" nil t t)

(require 'undo-tree)
;(global-undo-tree-mode)
(require 'magit)
(require 'unbound)
(require 'highlight-80+)
(require 'haml-mode)
(require 'delim-kill)
(require 'go-mode-load)
(if (require 'sml-modeline nil 'noerror)    ;; use sml-modeline if available
  (progn
    (sml-modeline-mode 1)))                   ;; show buffer pos in the mode line
(autoload 'scratch "scratch" nil t)
;(load "my-snippet")
;(load "my-cedet")
;(load "my-ecb")
(load "my-escreen")
(load "my-highlight-changes")
(load "my-keybindings")

(load "my-banshee")
(load "my-wl")
(load "my-w3m")

(require 'ido)
(ido-mode t)
(ido-everywhere 1)


(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
(custom-set-variables

  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(org-hide-leading-stars t)
 '(org-startup-folded nil))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:inherit outline-1 :weight bold :height 1.3))))
 '(org-todo ((t (:foreground "Pink" :weight bold)))))
(put 'narrow-to-region 'disabled nil)
