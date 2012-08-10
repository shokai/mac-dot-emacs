
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
