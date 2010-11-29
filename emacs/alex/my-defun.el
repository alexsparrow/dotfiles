;; show ascii table
;; optained from http://www.chrislott.org/geek/emacs/dotemacs.html
(defun ascii-table ()
  "Print the ascii table. Based on a defun by Alex Schroeder <asc@bsiag.com>"
  (interactive)
  (switch-to-buffer "*ASCII*")
  (erase-buffer)
  (insert (format "ASCII characters up to number %d.\n" 254))
  (let ((i 0))
    (while (< i 254)
      (setq i (+ i 1))
      (insert (format "%4d %c\n" i i))))
  (beginning-of-buffer))

(defun nuke-all-buffers ()
  "kill all buffers, leaving *scratch* only"
  (interactive)
  (mapcar (lambda (x) (kill-buffer x))
	  (buffer-list))
  (delete-other-windows))

; Bind increase/decrease font size to keys
(defun sacha/increase-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (ceiling (* 1.10
                                  (face-attribute 'default :height)))))
(defun sacha/decrease-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (floor (* 0.9
                                  (face-attribute 'default :height)))))

;; (defun intelligent-kill ()
;;   "quit the same way no matter what kind of window you are on"
;;   (interactive)
;; ;  (kill-buffer (buffer-name))
;;   (if (and (not (elscreen-one-screen-p)) (elscreen-kill))
;;       (message "Killed screen")
;;     (if (eq (car (visible-frame-list)) (selected-frame))
;;         ;;for parent/master frame…
;;         (if (> (length (visible-frame-list)) 1)
;;             ;;a parent with children present
;;             (delete-frame (selected-frame))
;;           ;;a parent with no children present
;;           (save-buffers-kill-emacs))
;;       ;;a child frame
;;       (delete-frame (selected-frame)))))

 (setq browse-url-browser-function 'w3m-browse-url)
 (autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
 ;; optional keyboard short-cut

; Transparency stuff
(defun djcb-opacity-modify (&optional dec)
  "modify the transparency of the emacs frame; if DEC is t,
    decrease the transparency, otherwise increase it in 10%-steps"
  (let* ((alpha-or-nil (frame-parameter nil 'alpha)) ; nil before setting
          (oldalpha (if alpha-or-nil alpha-or-nil 100))
          (newalpha (if dec (- oldalpha 10) (+ oldalpha 10))))
    (when (and (>= newalpha frame-alpha-lower-limit) (<= newalpha 100))
      (modify-frame-parameters nil (list (cons 'alpha newalpha))))))



(defun w3m-frame-unfocus()
  "Opens a new frame with w3m on it but don't focus it"
  (interactive)
  (progn
    (select-frame (make-frame '((name . "w3m browser")
				(minibuffer . t))))
    (w3m)
    (other-frame -1)))

    (defun fullscreen ()
      (interactive)
      (set-frame-parameter nil 'fullscreen
                           (if (frame-parameter nil 'fullscreen) nil 'fullboth)))


(defun copy-line (&optional arg)
  "Do a kill-line but copy rather than kill.  This function directly calls
kill-line, so see documentation of kill-line for how to use it including prefix
argument and relevant variables.  This function works by temporarily making the
buffer read-only, so I suggest setting kill-read-only-ok to t."
  (interactive "P")
  (toggle-read-only 1)
  (kill-line arg)
  (toggle-read-only 0))

; From http://github.com/rmm5t/dotfiles/blob/master/emacs.d/my-defuns.el
(defun iwb()
  "Indent Whole Buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))


(defun my-notify-popup (title msg &optional icon sound)
  "Show a popup if we're on X, or echo it otherwise; TITLE is the title
of the message, MSG is the context. Optionally, you can provide an ICON and
a sound to be played"

  (interactive)
  (when sound (shell-command
                (concat "mplayer -really-quiet " sound " 2> /dev/null")))
  (if (eq window-system 'x)
    (shell-command (concat "notify-send "

                     (if icon (concat "-i " icon) "")
                     " '" title "' '" msg "'"))
    ;; text only version

    (message (concat title ": " msg))))

; Taken from
; http://superuser.com/questions/67170/how-do-i-complete-file-paths-in-emacs
(defun my-expand-file-name-at-point ()
  "Use hippie-expand to expand the filename"
  (interactive)
  (let ((hippie-expand-try-functions-list '(try-complete-file-name-partially try-complete-file-name)))
    (call-interactively 'hippie-expand)))



; Adapted from http://www.emacswiki.org/emacs/AdvancedDeskCalculator#toc8
(defun calc-eval-region (arg beg end)
  "Calculate the region and display the result in the echo area.
With prefix ARG non-nil, insert the result at the end of region."
  (interactive "P\nr")
  (let* ((expr (buffer-substring-no-properties beg end))
         (result (calc-eval expr)))
    (if (null arg)
        (message "%s = %s" expr result)
      (kill-region beg end)
   ;  (goto-char end)
      (save-excursion
        (insert result)))))

(defun pydoc (&optional arg)
  (interactive)
  (when (not (stringp arg))
    (setq arg (thing-at-point 'word)))

  (setq cmd (concat "pydoc " arg))
  (ad-activate-regexp "auto-compile-yes-or-no-p-always-yes")
  (shell-command cmd)
  (setq pydoc-buf (get-buffer "*Shell Command Output*"))
  (switch-to-buffer-other-window pydoc-buf)
  (python-mode)
  (ad-deactivate-regexp "auto-compile-yes-or-no-p-always-yes")
)
