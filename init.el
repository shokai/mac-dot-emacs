(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/src")
(load "~/.emacs.d/scratch.el")

(setq-default tab-width 4 indent-tabs-mode nil) ;; disable tab
(setq backup-inhibited t) ;; disable tmp file
(setq auto-save-default nil)
(setq make-backup-files nil)
(define-key global-map [?¥] [?\\])
(global-set-key "\C-x;" 'ns-toggle-fullscreen) ;; for Cocoa Emacs
(column-number-mode t)
(setq-default show-trailing-whitespace t) ;; 行末space
(add-hook 'font-lock-mode-hook ;; 全角space highlight
          (lambda ()
            (font-lock-add-keywords
             nil
             '(("　" 0 'trailing-whitespace prepend)))))

(require 'ndmacro) (global-set-key (kbd "C-o") 'ndmacro)

;;c-mode
(defvar c-basic-offset 2)

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
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (rjsx-mode scala-mode jade-mode stylus-mode highlight-indentation highlight-indent-guides sass-mode scss-mode coffee-mode js2-mode auto-complete ## yasnippet)))
 '(ruby-insert-encoding-magic-comment nil))

;;css-mode
(setq css-indent-offset 2)

;;coffee-script-mode
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("\\.cjsx$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
(defun coffee-custom ()
  "coffee-mode-hook"
  (set (make-local-variable 'tab-width) 2)
  (setq coffee-tab-width 2)
  )
(add-hook 'coffee-mode-hook
          (lambda() (coffee-custom)))

;;js2-mode
(setq js-indent-level 2)
(setq js-switch-indent-offset 2)

;;es6-mode
(add-to-list 'auto-mode-alist '("\\.es6$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))
(add-hook 'js2-mode-hook
          (lambda ()
            (set (make-local-variable 'js2-indent-switch-body) t)
            ))

(require 'elixir-mode)
(add-to-list 'auto-mode-alist '("\\.exs$" . elixir-mode))

;;auto complete
(ac-config-default)
(global-auto-complete-mode "enter")
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
(setq ac-modes
      (append ac-modes
              (list 'scss-mode 'conf-mode 'coffee-mode 'js2-mode 'js2-jsx-mode 'jade-mode 'stylus-mode)))

;;yasnippet
(yas-global-mode 1)

(require 'ajc-java-complete-config)
(set 'ajc-tag-file "~/.emacs.d/ajc.tag")
(add-hook 'java-mode-hook 'ajc-java-complete-mode)
(add-hook 'find-file-hook 'ajc-4-jsp-find-file-hook)

(put 'set-goal-column 'disabled nil)

(require 'go-autocomplete)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
