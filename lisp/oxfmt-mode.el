;;; oxfmt-mode.el --- Minor mode for formatting with oxfmt on save -*- lexical-binding: t; -*-

(defun oxfmt-format-buffer ()
  "Format the current buffer using oxfmt."
  (when (and buffer-file-name
             (not (file-remote-p buffer-file-name))
             (not buffer-read-only)
             (executable-find "oxfmt"))
    (let* ((file-name (file-name-nondirectory buffer-file-name))
           (default-directory (file-name-directory buffer-file-name))
           (output-buffer (generate-new-buffer " *oxfmt-output*"))
           (exit-code (call-process-region
                       (point-min) (point-max)
                       "oxfmt" nil output-buffer nil
                       "--stdin-filepath" file-name)))
      (if (zerop exit-code)
          (replace-buffer-contents output-buffer)
        (message "oxfmt failed (exit %d)" exit-code))
      (kill-buffer output-buffer))))

;;;###autoload
(define-minor-mode oxfmt-mode
  "Minor mode to format buffer with oxfmt on save."
  :lighter " oxfmt"
  (if oxfmt-mode
      (add-hook 'before-save-hook #'oxfmt-format-buffer nil t)
    (remove-hook 'before-save-hook #'oxfmt-format-buffer t)))

(provide 'oxfmt-mode)
;;; oxfmt-mode.el ends here
