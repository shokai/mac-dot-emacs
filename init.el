(global-font-lock-mode t)

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
   '(## auto-complete coffee-mode jade-mode list-packages-ext
        markdown-mode prettier-js sass-mode scala-mode
        scss-mode stylus-mode typescript-mode yaml-mode yasnippet))
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


;;auto complete
(require 'auto-complete)
(require 'auto-complete-config)
;; デフォルト設定を適用
(ac-config-default)
;; グローバルモードを有効化（全てのバッファで自動補完を有効に）
(global-auto-complete-mode 1)
;; キーバインドの設定（ac-config-defaultの後に行うことで確実に反映される）
(with-eval-after-load 'auto-complete
  (define-key ac-completing-map "\C-n" 'ac-next)
  (define-key ac-completing-map "\C-p" 'ac-previous))
;; ac-modesに追加するモードを直接指定
(add-to-list 'ac-modes 'typescript-mode)
(add-to-list 'ac-modes 'scss-mode)
(add-to-list 'ac-modes 'conf-mode)
(add-to-list 'ac-modes 'coffee-mode)
(add-to-list 'ac-modes 'jade-mode)
(add-to-list 'ac-modes 'stylus-mode)
;; パフォーマンス向上のための設定
(setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
(setq ac-delay 0.2)                     ; 自動補完を開始するまでの時間
(setq ac-auto-start 2)                  ; 2文字以上で自動補完を開始
(setq ac-auto-show-menu 0.8)            ; メニューを表示するまでの時間（数値は秒数）
(setq-default ac-auto-show-menu 0.8)    ; より明示的に設定
(setq ac-use-comphist t)                ; 候補の履歴を考慮
(setq ac-candidate-limit 20)            ; 候補の最大表示数
(setq ac-use-quick-help t)              ; クイックヘルプを使用
(setq ac-quick-help-delay 1.0)          ; クイックヘルプの表示までの時間
(setq ac-ignore-case 'smart)            ; スマートケース（小文字の場合は大文字小文字を区別しない）
(setq ac-dwim t)                        ; Do What I Mean機能を有効化
(setq ac-use-menu-map t)                ; 補完メニュー表示時にC-n/C-pで補完候補選択

;;yasnippet
(yas-global-mode 1)

(put 'set-goal-column 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;prettier
(add-hook 'js-mode-hook 'prettier-js-mode)
(add-hook 'typescript-mode-hook 'prettier-js-mode)
(add-hook 'scss-mode-hook 'prettier-js-mode)
(add-hook 'conf-mode-hook 'prettier-js-mode)
(add-hook 'yaml-mode-hook 'prettier-js-mode)
(add-hook 'markdown-mode-hook 'prettier-js-mode)
