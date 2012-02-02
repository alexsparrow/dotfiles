(require 'dbus)

(dbus-list-known-names :session)
(defun alex-call-banshee (iface method  &rest args)
  "call the tomboy method METHOD with ARGS over dbus"
  (apply 'dbus-call-method
    :session                            ; use the session (not system) bus
    "org.bansheeproject.Banshee"                  ; service name
    (concat "/org/bansheeproject/Banshee/" iface)   ; path name
    (concat "org.bansheeproject.Banshee." iface)   ; interface name
    method args))

(defun alex-banshee-pause()
(interactive)
(alex-call-banshee "PlayerEngine" "Pause")
)


(defun alex-banshee-play()
(interactive)
(alex-call-banshee "PlayerEngine" "Play")
)

(defun alex-banshee-toggle()
(interactive)
(alex-call-banshee "PlayerEngine" "TogglePlaying")
)

(defun alex-banshee-next()
(interactive)
(alex-call-banshee "PlaybackController" "Next" nil)
)

(defun alex-banshee-prev()
(interactive)
(alex-call-banshee "PlaybackController" "Previous" nil)
)
