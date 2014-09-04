(add-to-list 'load-path "~/.emacs.d")
(load "~/.emacs.d/scratch.el")

(setq-default tab-width 4 indent-tabs-mode nil) ;; disable tab
(setq backup-inhibited t) ;; disable tmp file
(setq auto-save-default nil)
(setq make-backup-files nil)
(define-key global-map [?¥] [?\\])
(global-set-key "\C-x;" 'ns-toggle-fullscreen) ;; for Cocoa Emacs
(column-number-mode t)

(require 'highlight-indentation)
(set-face-background 'highlight-indentation-face "#608")
(set-face-background 'highlight-indentation-current-column-face "#93B")

;;go-mode
(require 'go-mode)
(add-to-list 'auto-mode-alist '("\\.go$" . go-mode))
(add-hook 'before-save-hook 'gofmt-before-save)

;;c++-mode (for arduino)
(add-to-list 'auto-mode-alist '("\\.ino$" . c++-mode))

;;ruby-mode
(add-to-list 'auto-mode-alist '("\\.r[bu]$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\Gemfile$" . ruby-mode))
(custom-set-variables
 '(ruby-insert-encoding-magic-comment nil))

;;haml-mode
(require 'haml-mode)
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))

;;sass-mode
(require 'sass-mode)
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . sass-mode))
(add-to-list 'auto-mode-alist '("\\.css$" . sass-mode))

;;coffee-script-mode
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
(defun coffee-custom ()
  "coffee-mode-hook"
  (set (make-local-variable 'tab-width) 2)
  (setq coffee-tab-width 2)
  )
(add-hook 'coffee-mode-hook
          (lambda() (coffee-custom)))

;;jade-mode
(require 'sws-mode)
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;;scala-mode
(require 'scala-mode-auto)

;;javascript-mode
(setq js-indent-level 2)

;;auto complete
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode "enter")
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
(setq ac-modes
      (append ac-modes
              (list 'sass-mode 'conf-mode 'coffee-mode)))

(require 'yasnippet)
(yas/global-mode 1)

(require 'ajc-java-complete-config)
(set 'ajc-tag-file "~/.emacs.d/ajc.tag")
(add-hook 'java-mode-hook 'ajc-java-complete-mode)
(add-hook 'find-file-hook 'ajc-4-jsp-find-file-hook)

(put 'set-goal-column 'disabled nil)

(require 'go-autocomplete)
