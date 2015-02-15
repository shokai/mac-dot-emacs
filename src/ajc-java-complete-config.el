;;; ajc-java-complete-config.el --- Auto Java Completion  for GNU Emacs

;;;  Install

;;;  Code

(require 'auto-complete)
(require 'yasnippet)
(require 'ajc-java-complete)


(defun ajc-expand-yasnippet-templete-with-ac ()
  (let* ((last-complete-string (cdr ac-last-completion))
         (yasnippet-templete (get-text-property 0 'templete last-complete-string))
         templete-type)
    (when  yasnippet-templete
      (setq templete-type  (get-text-property 0 'templete-type last-complete-string))
      (delete-char (- 0 (length last-complete-string)))
      (cond
       ((equal templete-type  'method)
        (yas/expand-snippet (ajc-method-to-yasnippet-templete yasnippet-templete) )
        )
       ((equal templete-type  'constructor)
        (yas/expand-snippet (ajc-constructor-to-yasnippet-templete yasnippet-templete))
        )))))


;;add support for jsp when import ,but you should trigger it by key-binding
;;for example (define-key ac-mode-map (kbd "M-1") 'auto-complete)
;;<%@ page language="java" import="java.io.File,java.util.Map,javax.sw-|-"%>
(defun prefix-support-jsp-importing ()
  (when   (re-search-backward "\\(import=\"\\(.*[ \t\n]*,[ \t\n]*\\)*\\)\\|\\(import[ \t]+\\)"  nil t)
    (match-end 0))
  )
;; sources for auto complete
(ac-define-source ajc-import
  '((candidates . (ajc-import-package-candidates))
    (prefix . prefix-support-jsp-importing)))

(ac-define-source ajc-class
  '((candidates . (ajc-complete-class-candidates ))
   (prefix . "\\b\\([A-Z][a-zA-Z0-9_]*\\)")
   (cache)))

(ac-define-source ajc-constructor
  '((candidates . (ajc-complete-constructor-candidates ))
   (cache)
   (requires . 3)
   (prefix . "\\bnew[ \t]+\\([A-Z][a-zA-Z0-9_]*[ \t]*(?\\)")
   (action . ajc-expand-yasnippet-templete-with-ac)))

(ac-define-source ajc-method
  '((candidates . (ajc-complete-method-candidates))
  (cache)
  (requires . 0)
  (prefix . "\\.\\(.*\\)")
  (action .  ajc-expand-yasnippet-templete-with-ac)))

(ac-define-source ajc-keywords
  '((candidates . (ajc-java-keywords-candidates))))
;; end of sources
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;hooks
(defun ajc-java-complete-init()
  (ajc-init)
;;  (add-to-list 'ac-sources 'ac-source-ajc-keywords)
  (add-to-list 'ac-sources 'ac-source-ajc-method)
  (add-to-list 'ac-sources 'ac-source-ajc-class)
  (add-to-list 'ac-sources 'ac-source-ajc-constructor)
  (add-to-list 'ac-sources 'ac-source-ajc-import)
;; auto import all Class in source file
(local-set-key (kbd "C-c i") 'ajc-import-all-unimported-class)
;; import Class where under point
(local-set-key (kbd "C-c m") 'ajc-import-class-under-point))

(defun ajc-java-complete-exit()
  (setq ac-sources (delete 'ac-source-ajc-constructor ac-sources))
  (setq ac-sources (delete 'ac-source-ajc-class ac-sources))
  (setq ac-sources (delete 'ac-source-ajc-method ac-sources))
  (setq ac-sources (delete 'ac-source-ajc-keywords ac-sources))
  (setq ac-sources (delete 'ac-source-ajc-import ac-sources)))


(defvar ajc-java-complete-mode-hook nil)
;;define minor-mode
;;;###autoload
(define-minor-mode ajc-java-complete-mode
  "AutoJavaComplete mode"
  :lighter " ajc"
  ;;  :keymap ajc-mode-map
  :group 'ajc-java-complete
  (if ajc-java-complete-mode
      (when (featurep 'auto-complete)
        (unless auto-complete-mode (auto-complete-mode))
        (ajc-java-complete-init))
    (ajc-java-complete-exit)))
;;;###autoload
(defalias 'auto-java-complete-mode 'ajc-java-complete-mode)

;; (add-hook 'find-file-hook 'ajc-4-jsp-find-file-hook)
;;;###autoload
(defun ajc-4-jsp-find-file-hook ()
  (let ((file-name-ext (file-name-extension (buffer-file-name)) ))
    (when (and file-name-ext (string-match "jsp" file-name-ext))
    (ajc-java-complete-mode))
  ))

(provide 'ajc-java-complete-config)
