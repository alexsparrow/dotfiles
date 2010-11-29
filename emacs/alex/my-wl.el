
;; wanderlust
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

(setq wl-stay-folder-window t)                       ;; show the folder pane (left)
(setq  wl-folder-window-width 25)                     ;; toggle on/off with 'i'


;; maildir
(setq elmo-maildir-folder-path "~/Mail"
      wl-fcc ".Sent"
      wl-fcc-force-as-read t               ;; mark sent messages as read
      wl-default-folder "."           ;; my main inbox
      wl-draft-folder ".Drafts"            ;; store drafts in 'postponed'
      wl-trash-folder ".Trash"             ;; put trash in 'trash'
      wl-spam-folder ".Trash"              ;; ...spam as well
      wl-queue-folder ".queue"             ;; we don't use this

      ;; check this folder periodically, and update modeline
      wl-biff-check-folder-list '(".todo") ;; check every 180 seconds
      ;; (default: wl-biff-check-interval)

      ;; hide many fields from message buffers
      wl-message-ignored-field-list '("^.*:")
      wl-message-visible-field-list
      '("^\\(To\\|Cc\\):"

	"^Subject:"
	"^\\(From\\|Reply-To\\):"
	"^Organization:"
	"^Message-Id:"
	"^\\(Posted\\|Date\\):"
	)
      wl-message-sort-field-list
      '("^From"

	"^Organization:"
	"^X-Attribution:"
	"^Subject"
	"^Date"
	"^To"
	"^Cc"))

;; IMAP
;; (setq elmo-imap4-default-server "imap.cern.ch")
;; (setq elmo-imap4-default-user "as1604")
;; (setq elmo-imap4-default-authenticate-type 'clear)
;; (setq elmo-imap4-default-port '993)
;; (setq elmo-imap4-default-stream-type 'ssl)

;; (setq elmo-imap4-use-modified-utf7 t)

;; SMTP
(setq wl-smtp-connection-type 'starttls)
(setq wl-smtp-posting-port 587)
(setq wl-smtp-authenticate-type "login")
(setq wl-smtp-posting-user "as1604")
(setq wl-smtp-posting-server "smtp.cc.ic.ac.uk")
(setq wl-local-domain "ic.ac.uk")

;; (setq wl-default-folder "%inbox")
;; (setq wl-default-spec "%")
;; (setq wl-draft-folder "%Drafts") ; Gmail IMAP
;; (setq wl-trash-folder "%Trash")

;; (setq wl-folder-check-async t)
;; (setq wl-message-id-domain "ic.ac.uk")
(setq wl-from "Alex Sparrow <alex.sparrow@cern.ch>")

(setq wl-biff-check-folder-list '("."))
(setq wl-biff-check-interval 30)

(add-hook 'wl-mail-setup-hook 'auto-fill-mode)

(setq elmo-imap4-use-modified-utf7 t)

(defun my-wl-update-current-summaries ()
   (let ((buffers (wl-collect-summary)))
     (while buffers
       (with-current-buffer (car buffers)
         (save-excursion
           (wl-summary-sync-update)))
       (setq buffers (cdr buffers)))))

(add-hook 'wl-biff-notify-hook 'my-wl-update-current-summaries)
(add-hook 'wl-biff-notify-hook
(lambda()
  (my-notify-popup "Wanderlust" "You have new mail!"
		   "/usr/share/icons/gnome/32x32/status/mail-unread.png"
		   "/usr/share/sounds/ubuntu/stereo/phone-incoming-call.ogg")))

(autoload 'wl-user-agent-compose "wl-draft" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))

