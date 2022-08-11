;;; java-helper.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 Gopinath Sadasivam
;;
;; Author: Gopinath Sadasivam <https://github.com/gopinat>
;; Maintainer: Gopinath Sadasivam <noemail@gopi>
;; Created: April 21, 2022
;; Modified: April 21, 2022
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/gopinat/java-helper
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(defgroup java-helper nil
  "Execute buffer quickly."
  :group 'myhelpers
  :prefix 'java-helper)


(defcustom java-helper-throwaway-root "c:/my/tmp/throwaway/java/"
  "Timeout seconds for running too long process."
  :type '(string)
  :group 'myhelpers)

(defvar java-helper--java-code
"public class Main
{
    public static void main(String[] args) {
        System.out.println(\"Welcome\");
    }
}
")
(defvar java-helper--java-tmp-dir nil)

(defun java-helper-create-throwaway-java-project ()
  "Create a simple throwaway project."
  (interactive)
  (setq java-helper--java-tmp-dir (concat java-helper-throwaway-root (format-time-string "%Y%m%d%-h%m%S") "-java/"))
  (make-directory java-helper--java-tmp-dir :parent)
  (find-file (concat java-helper--java-tmp-dir "Main.java"))
  (insert java-helper--java-code)
  (message "Creating throwaway project!!"))

(defun java-helper--read-clean-path (prompt)
  (replace-regexp-in-string "-+" "-"
                            (replace-regexp-in-string "[^[:alnum:]]" "-"
                                                      (read-string prompt
                                                                   (format-time-string "%Y%m%d-"))
                                                      )))


;; (defun java-helper-create-maven-quickstart-project()
;;   "Downloads zip from github and unzips it to create mvn java project."
;;   (interactive)
;;   (setq maven-app-url "https://github.com/infoparticle/project-templates/raw/main/java/myapp-hello-world.zip")
;;   (setq java-helper--java-tmp-dir (concat java-helper-throwaway-root
;;                                           (java-helper--read-clean-path "Enter java project folder name : ")
;;                                           ".javaproj/"))
;;   (make-directory java-helper--java-tmp-dir :parent)
;;   (setq abs-path-zip-file (concat java-helper--java-tmp-dir "app-maven.zip"))
;;   (url-copy-file maven-app-url abs-path-zip-file)
;;   (shell-command
;;    (concat "cd " java-helper--java-tmp-dir " && " "unzip -oq " "app-maven.zip"
;;            " && rm app-maven.zip")))

(defun java-helper-create-simple-maven-project ()
  (interactive)
  (cd "c:/my/tmp/throwaway/java")
  (compile  "cookiecutter 'c:/Users/gopinat/AppData/Roaming/emacstools/cookiecutter-templates/java/simple-maven-java-project'" t))


(provide 'java-helper)
;;; java-helper.el ends here
