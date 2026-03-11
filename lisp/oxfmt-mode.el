;;; oxfmt-mode.el --- Minor mode for formatting with oxfmt on save -*- lexical-binding: t; -*-

(defvar-local oxfmt-mode--use-prettier nil
  "Non-nil means use prettier instead of oxfmt.")

(defun oxfmt-format-buffer ()
  "Format the current buffer using oxfmt or prettier."
  (when (and buffer-file-name
             (not (file-remote-p buffer-file-name))
             (not buffer-read-only))
    (let* ((formatter (if oxfmt-mode--use-prettier "prettier" "oxfmt"))
           (file-name (file-name-nondirectory buffer-file-name))
           (default-directory (file-name-directory buffer-file-name))
           (output-buffer (generate-new-buffer " *oxfmt-output*"))
           (error-file (make-temp-file "oxfmt-stderr")))
      (if (not (executable-find formatter))
          (message "%s not found" formatter)
        (unwind-protect
            (let ((exit-code (call-process-region
                              (point-min) (point-max)
                              formatter nil (list output-buffer error-file) nil
                              "--stdin-filepath" file-name)))
              (if (zerop exit-code)
                  (replace-buffer-contents output-buffer)
                (message "%s failed (exit %d): %s" formatter exit-code
                         (string-trim
                          (with-temp-buffer
                            (insert-file-contents error-file)
                            (buffer-string))))))
          (kill-buffer output-buffer)
          (delete-file error-file))))))

(defun oxfmt-mode-prettier ()
  "Toggle between oxfmt and prettier for this buffer."
  (interactive)
  (setq oxfmt-mode--use-prettier (not oxfmt-mode--use-prettier))
  (force-mode-line-update)
  (message "Formatter: %s" (if oxfmt-mode--use-prettier "prettier" "oxfmt")))

;;;###autoload
(define-minor-mode oxfmt-mode
  "Minor mode to format buffer with oxfmt on save."
  :lighter (:eval (if oxfmt-mode--use-prettier " prettier" " oxfmt"))
  (if oxfmt-mode
      (add-hook 'before-save-hook #'oxfmt-format-buffer nil t)
    (remove-hook 'before-save-hook #'oxfmt-format-buffer t)))

(provide 'oxfmt-mode)
;;; oxfmt-mode.el ends here
