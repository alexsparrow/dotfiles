(require 'compile)
;(autoload 'python-pylint "python-pylint")
; (autoload 'pylint "python-pylint")

; (autoload 'python-pep8 "python-pep8")
; (autoload 'pep8 "python-pep8")
(require 'python-pep8)
(require 'python-pylint)

(require 'ipython)
;; (setq py-python-command-args '("-pylab" "-colors" "LightBG"))
(setq py-python-command-args '( "-colors" "Linux"))

(add-hook 'python-mode-hook
          '(lambda () (eldoc-mode 1)) t)
