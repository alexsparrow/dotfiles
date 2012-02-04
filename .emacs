; Emacs Load Path
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "~/.emacs.d")
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
(load "my-shell")

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

;(load "my-snippet")
;(load "my-cedet")
;(load "my-ecb")
(load "my-escreen")
(load "my-highlight-changes")
(load "my-keybindings")

(load "my-banshee")
(load "my-wl")
(load "my-w3m")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(comint-completion-addsuffix t)
 '(comint-completion-autolist t)
 '(comint-input-ignoredups t)
 '(comint-move-point-for-output t)
 '(comint-scroll-show-maximum-output t)
 '(comint-scroll-to-bottom-on-input t)
 '(org-hide-leading-stars t)
 '(org-startup-folded nil)
 '(safe-local-variable-values (quote ((TeX-pdf-mode . t)))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-checkbox ((t (:background "#859900" :foreground "#002b36" :box (:line-width 1 :style released-button)))))
 '(org-done ((t (:background "#859900" :foreground "#002b36" :box (:line-width 1 :style released-button)))))
 '(org-level-1 ((t (:inherit outline-1 :weight bold :height 1.3))))
 '(org-todo ((t (:background "#dc322f" :foreground "#002b36" :box (:line-width 1 :style released-button))))))


;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
;; (when
;;     (load
;;      (expand-file-name "~/.emacs.d/elpa/package.el"))
;;   (package-initialize))
