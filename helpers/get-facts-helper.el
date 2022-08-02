
(defun my/get-facts (filepath)
  (setq my-retloc (point))
  (find-file filepath)
  (counsel-org-goto)
  (search-forward "#+begin_src")
  (org-edit-src-code)
  (clipboard-kill-region (point-min) (point-max))
  (org-edit-src-abort)
  ;;(kill-buffer)
  ;;(previous-buffer)
  (switch-to-prev-buffer)
  (yank)
  )

(defun gf/trading() (interactive) (my/get-facts "~/emacstools/facts.d/trading/trading.facts.org"))

(defun gf/work() (interactive) (my/get-facts "~/emacstools/facts.d/work/work.facts.org"))

(defun gf/rum-apm() (interactive) (my/get-facts "c:/my/work/gitrepos/rum-work-notes.git/contents/private/rum-apm.facts.org"))

(defun gf/life() (interactive) (my/get-facts "~/emacstools/facts.d/life/life.facts.org"))

(defun gf/concepts-glossary() (interactive) (my/get-facts "~/emacstools/facts.d/concepts/concepts-glossary.facts.org"))

(defun gf/gists/git() (interactive) (my/get-facts "~/emacstools/facts.d/gists/git.facts.org"))

(defun gf/gists/python() (interactive) (my/get-facts "~/emacstools/facts.d/gists/python/python.facts.org"))
(defun gf/gists/lisp() (interactive) (my/get-facts "~/emacstools/facts.d/gists/lisp/lisp.facts.org"))
(defun gf/gists/java() (interactive) (my/get-facts "~/emacstools/facts.d/gists/java/java.facts.org"))
