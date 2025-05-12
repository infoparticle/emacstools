(defvar cheat-repo-root "~/emacstools/cheat/cheat-repo/")

(defun cheat-select-info ()
  (interactive)
  (let* ((cheat-dir-abs (expand-file-name cheat-repo-root))
         (files (directory-files-recursively cheat-dir-abs "\\.org$" nil))
         (cheat-docs (mapcar (lambda (f) (file-relative-name f cheat-dir-abs)) files))
         (selected (completing-read "Choose your reference: " cheat-docs nil t))
         (qref-buf (get-buffer-create "*QUICK-REF*")))
    (when selected
      (with-current-buffer qref-buf
        (goto-char (point-max))
        (insert-file-contents (concat cheat-dir-abs selected))
        (insert (concat "\n** " (current-time-string) "\n"))
        (evil-mode)
        (org-mode)
        ;; (pop-to-buffer qref-buf)
        (local-set-key (kbd "q") 'quit-window)
        (display-buffer-below-selected qref-buf '((window-height . 20)))))))
