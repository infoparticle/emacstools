(defun base64-to-base64url (str)
  (setq str (replace-regexp-in-string "=+$" "" str))
  (setq str (replace-regexp-in-string "+" "-" str))
  (setq str (replace-regexp-in-string "/" "_" str)))

(defun base64url-to-base64 (str)
  (setq str (replace-regexp-in-string "-" "+" str))
  (setq str (replace-regexp-in-string "_" "/" str))
  (let ((mod (% (length str) 4)))
    (cond
     ((= mod 1) (concat str "==="))
     ((= mod 2) (concat str "=="))
     ((= mod 3) (concat str "="))
     (t str))))

(defun base64url-encode-string (str)
  (base64-to-base64url (base64-encode-string str t)))

(defun base64url-decode-string (str)
  (base64-decode-string (base64url-to-base64 str)))
