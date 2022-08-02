(defun load-helper-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file "~/emacstools/helpers")))

(load-helper-file "welcome.el")
(load-helper-file "string-helpers.el")
(load-helper-file "java-helper.el")
(load-helper-file "python-helper.el")
(load-helper-file "get-facts-helper.el")
