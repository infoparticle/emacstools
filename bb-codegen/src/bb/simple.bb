(ns bb.simple
    (:require [clojure.edn :as edn]
              [selmer.parser :as selmer]))

(defn- render-template [template-path context]
       (selmer/render-file (str "templates/" template-path) context))

(defn -main [& args]
      (let [input (-> (first args) slurp edn/read-string)
                  template (:template input)
                  context (dissoc input :template)]
        (println (render-template template context))))
