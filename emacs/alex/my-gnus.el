
(defun my-message-mode-setup ()
  (setq fill-column 72)
  (turn-on-auto-fill))
(add-hook 'message-mode-hook 'my-message-mode-setup)

;; http://groups.google.com/group/gnu.emacs.gnus/browse_thread/thread/a673a74356e7141f
(when window-system
  (setq gnus-sum-thread-tree-indent "  ")
  (setq gnus-sum-thread-tree-root "") ;; "● ")
  (setq gnus-sum-thread-tree-false-root "") ;; "◯ ")
  (setq gnus-sum-thread-tree-single-indent "") ;; "◎ ")
  (setq gnus-sum-thread-tree-vertical        "│")
  (setq gnus-sum-thread-tree-leaf-with-other "├─► ")
  (setq gnus-sum-thread-tree-single-leaf     "╰─► "))
(setq gnus-summary-line-format
      (concat
       "%0{%U%R%z%}"
       "%3{│%}" "%1{%d%}" "%3{│%}" ;; date
       "  "
       "%4{%-20,20f%}"               ;; name
       "  "
       "%3{│%}"
       " "
       "%1{%B%}"
       "%s\n"))
(setq gnus-summary-display-arrow t)




(setq gnus-group-line-format "%M%S%5y:%B%(%c%)\n")

(gnus-add-configuration
 '(article
   (horizontal 1.0
	       (vertical 25
			 (group 1.0))
	       (vertical 1.0
			 (summary 0.25 point)
			 (article 1.0)))))
(gnus-add-configuration
 '(summary
   (horizontal 1.0
	       (vertical 25
			 (group 1.0))
	       (vertical 1.0
			 (summary 1.0 point)))))

; http://paste.lisp.org/display/4480

;; ;; *Group* buffer: how to format each group entry.
;; (setq gnus-group-line-format
;; "%M%m %4N/%4t non-lus: %(%-20,20g%) depuis le %2,2~(cut 6)\
;; d/%2,2~(cut 4)d à %2,2~(cut 9)dh%2,2~(cut 11)d\n"
;;       ;;
;;       ;; %var details C-h i
;;       ;;`M' An asterisk if the group only has marked articles.
;;       ;;'N' Number of unread articles.
;;       ;;`t' Estimated total number of articles.
;;       ;;`G' Group name.
;;       ;;`D' Newsgroup description.
;;       ;;`m' `%' (`gnus-new-mail-mark') if there has arrived new mail to the
;;       ;;    group lately.
;;       ;;`D' Last time the group as been accessed.
;;       ;;
;;       ;; For the record, a default group line format
;;       ;;(setq gnus-group-line-format "%M\%S\%p\%P\%5y: %(%-40,40g%) %6,6~(cut 2)d\n")
;;       )

;; ;; *Summary*: how to format each mail entry.
;; (setq gnus-summary-line-format
;; "%-1R %-1U  %-15,15n | %2,2~(cut 6)o/%2,2~(cut 4)o %2,2~(cut 9)oh%2,2~(cut 11)\
;; o | %I%(%0,40s%)\n"
;;       gnus-summary-same-subject ">>>"
;;       gnus-summary-mode-line-format "%V: %%b"
;;       ;; %var details C-h i
;;       ;; `s' Subject if the article is the root of the thread or the previous
;;       ;;     article had a different subject, `gnus-summary-same-subject'
;;       ;;     otherwise.  (`gnus-summary-same-subject' defaults to `""'.)
;;       ;; `n' The name (from the `From' header).
;;       ;; `L' Number of lines in the article.
;;       ;; `I' Indentation based on thread level (*note Customizing Threading::).
;;       ;; `>' One space for each thread level.
;;       ;; `<' Twenty minus thread level spaces.
;;       ;; `U' Unread.
;;       ;; `R' This misleadingly named specifier is the "secondary mark".  This
;;       ;;     mark will say whether the article has been replied to, has been
;;       ;;     cached, or has been saved.
;;       ;; `D'  `Date'.
;;       ;; `d'  The `Date' in `DD-MMM' format.
;;       ;;`o'     The `Date' in YYYYMMDD`T'HHMMSS format.
;;  ;;
;;       ;; For the record the default string is
;;       ;; `%U%R%z%I%(%[%4L: %-20,20n%]%) %s\n'.
;;       )



