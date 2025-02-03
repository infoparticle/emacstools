(ns bb.emacs
    (:require [clojure.edn :as edn]
              [selmer.parser :as selmer]))

(defn- render-template [template-path context]
       (selmer/render-file (str "templates/" template-path) context))

(defn -main [& args]
      (let [input (-> (first args) slurp edn/read-string)
                  template_path (second args)]
                  ;(println template_path)
                  ;(println input)
        (println (render-template template_path input))))
