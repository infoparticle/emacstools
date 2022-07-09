(defun python-helper-create-quickstart-project ()
  (interactive)
  (cd "c:/my/tmp/throwaway/python")
  (compile  "cookiecutter 'c:/Users/gopinat/AppData/Roaming/emacstools/cookiecutter-templates/python/simple-pyproj'" t))



(make-comint-in-buffer
 "cookiecutter python project creation"
 "*cookiecutter python*" "cookiecutter" nil
  "c:/Users/gopinat/AppData/Roaming/emacstools/cookiecutter-templates/python/simple-pyproj"
 )


(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))
