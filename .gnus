; -*- Lisp -*-

; Setting the imap-ssl-program like this isn't strictly necessary, but
; I do it anyway since I'm paranoid. (I think it will default to
; `-ssl2' instead of `-tls1' if you don't do this.)
;(setq imap-ssl-program "openssl s_client -ssl2 -connect %s:%p")

; Since I use gnus primarily for mail and not for reading News, I
; make my IMAP setting the default method for gnus.
(setq gnus-select-method '(nnimap "CERN"
				  (nnimap-address "imap.cern.ch")
				  (nnimap-stream ssl)
				  (nnimap-server-port 993)
                                                 (nnimap-logout-timeout 10)
                                                 (nnimap-list-pattern ("INBOX" "Cern Spam" "mail.*" ))
                                                 (nnir-search-engine imap)))

;; Fetch only part of the article if we can.  I saw this in someone
;; else's .gnus
(setq gnus-read-active-file 'some)

;; Tree view for groups.  I like the organisational feel this has.
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

;; Threads!  I hate reading un-threaded email -- especially mailing
;; lists.  This helps a ton!
(setq gnus-summary-thread-gathering-function
      'gnus-gather-threads-by-subject)

;; Also, I prefer to see only the top level message.  If a message has
;; several replies or is part of a thread, only show the first
;; message.  'gnus-thread-ignore-subject' will ignore the subject and
;; look at 'In-Reply-To:' and 'References:' headers.
(setq gnus-thread-hide-subtree t)
(setq gnus-thread-ignore-subject t)


(setq nnimap-crosspost nil)
(setq nnimap-split-inbox '("INBOX"))
(setq nnimap-split-predicate "UNDELETED")
(setq nnimap-split-rule 'nnimap-split-fancy)
