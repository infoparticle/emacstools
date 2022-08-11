(defun python-helper-create-quickstart-project ()
  (interactive)
  (cd "c:/my/tmp/throwaway/python")
  (compile  "cookiecutter 'c:/Users/gopinat/AppData/Roaming/emacstools/cookiecutter-templates/python/simple-pyproj'" t))


;; Interactive way to call comint buffer
;; (make-comint-in-buffer
;;  "cookiecutter python project creation"
;;  "*cookiecutter python*" "cookiecutter" nil
;;   "c:/Users/gopinat/AppData/Roaming/emacstools/cookiecutter-templates/python/simple-pyproj"
;;  )
