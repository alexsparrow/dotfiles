; ======================================
; Key Bindings
; ======================================
;Show line numbers
(global-set-key (kbd "s-<f1>") 'linum-mode)
(global-set-key (kbd "s-<f2>")  'tool-bar-mode)
(global-set-key (kbd "s-<f3>")  'menu-bar-mode)

(global-set-key (kbd "s-<f4>") 'fullscreen)
;; (global-set-key (kbd "<f6>") 'wcy-switch-buffer-forward)
;; (global-set-key (kbd "<f5>") 'wcy-switch-buffer-backward)

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cr" 'org-remember)

(global-set-key (kbd "<f7>") 'highlight-changes-mode)
;; toggle changes visibility
(global-set-key (kbd "<f8>")      'highlight-changes-visible-mode) ;; changes
;; remove the change-highlight in region
(global-set-key (kbd "S-<f8>")    'highlight-changes-remove-highlight)
;; alt-pgup/pgdown jump to the previous/next change
(global-set-key (kbd "<M-prior>") 'highlight-changes-next-change)
(global-set-key (kbd "<M-next>")  'highlight-changes-previous-change)

;; (global-set-key [(control shift h)] 'tabbar-mode)
;; (global-set-key [(control shift up)] 'tabbar-backward-group)
;; (global-set-key [(control shift down)] 'tabbar-forward-group)
;; (global-set-key [(control shift left)] 'tabbar-backward)
;; (global-set-key [(control shift right)] 'tabbar-forward)
;; (global-set-key [(control next)] 'tabbar-forward-tab)
;; (global-set-key [(control prior)] 'tabbar-backward-tab)
;(global-set-key [(control tab)] 'tabbar-last-selected-tab)

(global-set-key (kbd "C-+") 'sacha/increase-font-size)
(global-set-key (kbd "C--") 'sacha/decrease-font-size)

;;; C-x C-c closes frame or tab
(global-set-key "\C-x\C-c" `intelligent-kill)

 ;; C-8 will increase opacity (== decrease transparency)
 ;; C-9 will decrease opacity (== increase transparency
 ;; C-0 will returns the state to normal
(global-set-key (kbd "C-8") '(lambda()(interactive)(djcb-opacity-modify)))
(global-set-key (kbd "C-9") '(lambda()(interactive)(djcb-opacity-modify t)))
(global-set-key (kbd "C-0") '(lambda()(interactive)
                               (modify-frame-parameters nil `((alpha . 100)))))

(global-set-key (kbd "s-a") `intelligent-kill)

 (global-set-key "\C-xm" 'browse-url-at-point)



(global-set-key "\C-c\C-k" 'copy-line)

(global-set-key (kbd "s-c") 'ecb-minor-mode)

(global-set-key (kbd "s-i") 'iwb)

(global-set-key (kbd "s-h") 'highlight-80+-mode)

; I prefer s-s but Ubuntu seems to have stolen that since 10.04
(global-set-key (kbd "s-x") 'toggle-scroll-bar)
; Banshee stuff
(global-set-key (kbd "s-p") 'alex-banshee-toggle)
(global-set-key (kbd "s-.") 'alex-banshee-next)
(global-set-key (kbd "s-,") 'alex-banshee-prev)

(global-set-key (kbd "C-M-/") 'my-expand-file-name-at-point)
