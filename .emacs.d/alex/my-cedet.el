(load-file "~/.emacs-lisp/vendor/cedet/common/cedet.el")
(global-ede-mode 1)                      ; Enable the Project management system
(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
(global-srecode-minor-mode 1)            ; Enable template insertion menu

(semantic-load-enable-code-helpers)
(require 'semantic-ia)

(semantic-load-enable-all-exuberent-ctags-support)
(setq semantic-python-dependency-system-include-path
      '("/usr/lib/python2.6/" "/usr/lib/python2.6/dist-packages" "/usr/lib/pymodules/python2.6"))

(require 'semantic-gcc)

;(semantic-add-system-include "/usr/include/c++/4.4" 'c++-mode)
;(semantic-add-system-include "/usr/include/c++/4.4/x86_64-linux-gnu" 'c++-mode)
(defun my-cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle))
(add-hook 'c-mode-common-hook 'my-cedet-hook)
