(defun my/mvn-build-project ()
  "build current java module with maven"
  (interactive)
  (cd (projectile-project-root))
  (async-shell-command "mvn.cmd clean install -Dmaven.test.skip=true" "*maven-build*")
  ;;  (async-shell-command "java -version" "*maven-build*")
  )

(defun my/async ()
  (interactive)
  (async-shell-command "echo $PATH"  "*output*") )
