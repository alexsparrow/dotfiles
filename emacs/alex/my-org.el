; Org setup
(require 'org-install)

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(setq org-log-done t)
(org-remember-insinuate)
(setq org-directory "~/Org/")

(setq org-agenda-files "~/Org/agenda_files")
(setq org-default-notes-file (concat org-directory "/notes.org"))

(setq org-export-with-LaTeX-fragments t)
(setq org-attach-method 'cp)
(setq org-completion-use-ido t)
(setq org-remember-default-headline "Tasks")

;; (setq org-capture-templates
;;       (quote
;;        (("t" "todo" entry (file+headline "todo.org" "inbox")
;;          "* TODO %?%a\n %U\n"
;;          :clock-in t
;;          :clock-resume t))))

(setq org-capture-templates
      '(("s" "Todo" entry (file+headline "~/Org/gtd.org" "Tasks")
             "* TODO %?\n  %i\n  %a")
	("t" "Todo" entry (file+headline "~/Org/gtd.org" "Tasks")
             "* TODO %?\n  %i\n")
        ("j" "Journal" entry (file+datetree "~/Org/journal.org")
             "* %?\nEntered on %U\n  %i\n  %a")
	("l" "Logbook" entry (file+datetree "~/Org/logbook.org")
	 "* %?\nEntered on %U\n  %i\n  %a")
))

(setq org-todo-keywords
      (quote ((sequence
               "TODO(t)"
               "NEXT(n)"
               "STARTED(s)"
               "|" "DONE(d!/!)" "CANCELLED(c@/!)")
              (sequence "INBOX")
	      (sequence "MEET" "|" "FINISHED(f)")
)))

(custom-set-variables
 '(org-hide-leading-stars t)
 '(org-startup-folded nil))

(global-set-key (kbd "C-c c") 'org-capture)
(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :weight bold :height 1.3))))
 '(org-todo ((t (:foreground "Pink" :weight bold)))))

(require 'org-publish)
(setq org-publish-project-alist
      '(

	("org-notes"
	 :base-directory "~/Research/org/"
	 :base-extension "org"
	 :publishing-directory "~/Research/html/"
	 :recursive t
	 :publishing-function org-publish-org-to-html
	 :auto-index t                  ; Generate index.org automagically...
	 :index-filename "sitemap.org"  ; ... call it sitemap.org ...
	 :index-title "Sitemap"         ; ... with title 'Sitemap'.
	 :headline-levels 4             ; Just the default for this project.
	 :auto-preamble t
	 )

	("org-static"
	 :base-directory "~/Research/org/"
	 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
	 :publishing-directory "~/Research/html/"
	 :recursive t
	 :publishing-function org-publish-attachment
	 )

	("org" :components ("org-notes" "org-static"))
      ))

; This needed to make equations a bit bigger in preview mode (i.e 1.7 vs 1.0)
(setq org-format-latex-options '(:foreground default :background default :scale 1.7
    :html-foreground "Black" :html-background "Transparent" :html-scale 1.0
    :matchers ("begin" "$" "$$" "\\(" "\\[")))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(org-hide-leading-stars t)
 '(org-startup-folded nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:inherit outline-1 :weight bold :height 1.3))))
 '(org-todo ((t (:foreground "Pink" :weight bold)))))

(setq org-link-abbrev-alist '(("att" . org-attach-expand-link)))

;; Beamer stuff from emacs-fu
;; allow for export=>beamer by placing

;; #+LaTeX_CLASS: beamer in org files
;; (unless (boundp 'org-export-latex-classes)
;;   (setq org-export-latex-classes nil))
;; (add-to-list 'org-export-latex-classes
;;   ;; beamer class, for presentations
;;   '("beamer"
;;      "\\documentclass[11pt]{beamer}\n
;;       \\mode<{{{beamermode}}}>\n
;;       \\usetheme{{{{beamertheme}}}}\n
;;       \\usecolortheme{{{{beamercolortheme}}}}\n

;;       \\newcommand\\T{\\rule{0pt}{2.6ex}}\n
;;       \\newcommand\\B{\\rule[-1.2ex]{0pt}{0pt}}\n
;; \\newenvironment{changemargin}[2]{%\n
;;  \\begin{list}{}{%\n
;;     \\setlength{\topsep}{0pt}%\n
;;     \\setlength{\leftmargin}{#1}%\n
;;     \\setlength{\rightmargin}{#2}%\n
;;     \\setlength{\listparindent}{\parindent}%\n
;;     \\setlength{\itemindent}{\parindent}%\n
;;     \\setlength{\parsep}{\parskip}%\n
;;   }%\n
;;   \\item[]}{\end{list}}\n

;;       \\setbeameroption{show notes}\n
;;       \\usepackage[utf8]{inputenc}\n
;;       \\usepackage[T1]{fontenc}\n
;;       \\usepackage{hyperref}\n
;;       \\usepackage{color}
;;       \\usepackage{listings}
;;       \\lstset{numbers=none,language=[ISO]C++,tabsize=4,
;;   frame=single,
;;   basicstyle=\\small,
;;   showspaces=false,showstringspaces=false,
;;   showtabs=false,
;;   keywordstyle=\\color{blue}\\bfseries,
;;   commentstyle=\\color{red},
;;   }\n
;;       \\usepackage{verbatim}\n
;;       \\institute{{{{beamerinstitute}}}}\n
;;        \\subject{{{{beamersubject}}}}\n

;; \\mode<presentation> {\n
;;   \\setbeamertemplate{navigation symbols}{}\n
;; }\n
;; "

;;      ("\\section{%s}" . "");\\section*{%s}")

;;      ("\\begin{frame}[fragile]\\frametitle{%s}"
;;        "\\end{frame}"
;;        "\\begin{frame}[fragile]\\frametitle{%s}"
;;        "\\end{frame}")))

;;   ;; letter class, for formal letters

;;   (add-to-list 'org-export-latex-classes

;;   '("letter"
;;      "\\documentclass[11pt]{letter}\n
;;       \\usepackage[utf8]{inputenc}\n
;;       \\usepackage[T1]{fontenc}\n
;;       \\usepackage{color}"

;;      ("\\section{%s}" . "\\section*{%s}")
;;      ("\\subsection{%s}" . "\\subsection*{%s}")
;;      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;;      ("\\paragraph{%s}" . "\\paragraph*{%s}")
;;      ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

 (add-hook 'org-mode-hook
           '(lambda ()
             ;; unnecessary
             ;; (make-variable-buffer-local
 'iimage-mode-image-filename-regex)
             (let ((file-extension-regex
                    (regexp-opt (nconc (mapcar #'upcase
                                               image-file-name-extensions)
                                       image-file-name-extensions)
                                t)))
               (setq iimage-mode-image-regex-alist
                     (list
                      (cons
                       (concat
                        "\\[\\["
                        (regexp-quote "file:")
                        "\\([^]]+\." file-extension-regex "\\)"
                        "\\]"
                        "\\(\\[" "\\([^]]+\\)" "\\]\\)?"
                        "\\]")
                       1)))))
