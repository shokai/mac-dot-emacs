
(defun html-quote (start end)
  "選択範囲の「< > & 」と引用符記号「\"」をエスケープする"
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region start end)
      (goto-char (point-min))
      (while (re-search-forward "&" nil t)
        (replace-match "&amp;"))
      (goto-char (point-min))
      (while (re-search-forward "<" nil t)
        (replace-match "&lt;"))
      (goto-char (point-min))
      (while (re-search-forward ">" nil t)
        (replace-match "&gt;"))
      (goto-char (point-min))
      )))

;; scss/sass mode settings
(when (require 'web-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.sass\\'" . web-mode))
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (add-hook 'web-mode-hook
            (lambda ()
              (when (and (buffer-file-name)
                        (string-match-p "\\.s\\(c\\|a\\)ss\\'" (buffer-file-name)))
                (setq web-mode-enable-css-colorization t)))))
