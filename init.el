(global-font-lock-mode t)
(menu-bar-mode -1)  ;; メニューバーを非表示にする

;; 外部で編集されたファイルを自動的にリロードする
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

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

;;c-mode
(defvar c-basic-offset 2)

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
   '(## coffee-mode company jade-mode list-packages-ext markdown-mode
        prettier scala-mode stylus-mode typescript-mode web-mode
        yaml-mode))
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

;;js-mode
(setq js-indent-level 2)
(setq js-switch-indent-offset 2)

;;typescript-mode
(setq typescript-indent-level 2)

;;tide (TypeScript IDE)
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

;; TypeScript
(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; JSXをTypeScriptモードで開く
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))

;; JavaScript
(add-hook 'js-mode-hook #'setup-tide-mode)
;; JSX
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js-mode))
(setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))


;;company-mode
(unless (package-installed-p 'company)
  (package-refresh-contents)
  (package-install 'company))

(require 'company)
(global-company-mode 1)
(setq company-idle-delay 0.3)
(setq company-minimum-prefix-length 2)
(setq company-selection-wrap-around t)


(put 'set-goal-column 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;prettier
(add-hook 'js-mode-hook 'prettier-mode)
(add-hook 'js-json-mode-hook 'prettier-mode)
(add-hook 'typescript-mode-hook 'prettier-mode)
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-match-p "\\.s\\(c\\|a\\)ss\\'" (buffer-file-name))
              (prettier-mode))))
(add-hook 'conf-mode-hook 'prettier-mode)
(add-hook 'yaml-mode-hook 'prettier-mode)
(add-hook 'markdown-mode-hook 'prettier-mode)
