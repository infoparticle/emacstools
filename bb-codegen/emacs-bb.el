;;; -*- lexical-binding: t; -*-

(defvar bb-gen-root "~/emacstools/bb-codegen/")

(defun bb-select-templates ()
  (let* ((template-dir (concat bb-gen-root "src/templates/"))
         (template-dir-abs (expand-file-name template-dir))
         (files (directory-files-recursively template-dir-abs "\\.selmer$" nil))
         (templates (mapcar (lambda (f) (file-relative-name f template-dir-abs)) files))
         (selected (completing-read "Choose template: " templates nil t)))
    (when selected
      selected)))

;; (message (bb-select-templates))
(defun bb--extract-print-args-block-from-file (file-path)
  "Extract text between print_args markers from FILE-PATH using rx."
  (with-temp-buffer
    (insert-file-contents file-path)
    (let ((start-rx (rx (seq "{%" (0+ space) "if" (0+ space) "print_args" (0+ space) "%}")))
          (end-rx (rx (seq "{%" (0+ space) "endif" (0+ space) "%}"))))
      (when (re-search-forward start-rx nil t)
        (let ((content-start (point)))
          (when (re-search-forward end-rx nil t)
            (let ((content-end (match-beginning 0)))
              ;; Extract and clean the content
              (buffer-substring-no-properties content-start content-end))))))))



(defun bb-generate-code ()
  (interactive)
  (bb-popup-edn-config (bb-select-templates)))

(defun bb-popup-edn-config (template_path)
  "Edit EDN config and run code generation, output to *codegen-output*."
  (let* ((input-file "c:/tmp/del.edn")
         (buf (get-buffer-create "*codegen-input*"))
         (window-conf (current-window-configuration)))

    (setq my-input-file input-file)
    (setq my-window-conf window-conf)
    (setq my-template-path template_path)
    (with-current-buffer buf
      (erase-buffer)
      (when (file-exists-p input-file)
        (insert (extract-print-args-block-from-file (concat  bb-gen-root "src/templates/" template_path))))
      (pop-to-buffer buf)

      (local-set-key
       (kbd "C-c C-c")
       (lambda ()
         (interactive)
         (write-region (point-min) (point-max) my-input-file)
         (set-window-configuration my-window-conf)

         ;; Run generation and output to dedicated buffer
         (let* ((default-directory "~/emacstools/bb-codegen")
                (output-buffer (get-buffer-create "*codegen-output*")))
           (call-process "bb" nil t nil
                         "-m" "bb.emacs"
                         my-input-file
                         my-template-path)))))))
