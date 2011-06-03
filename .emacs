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


