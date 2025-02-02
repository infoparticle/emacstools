(ns bb.advanced
  (:require [clojure.edn :as edn]
            [clojure.java.io :as io]
            [selmer.parser :as selmer]
            [clojure.java.jdbc :as jdbc]))

(defn- create-directories! [path]
  (io/make-parents path)
  (println "Created directories for:" path))

(defn- render-and-save! [template-path output-path context]
  (let [content (selmer/render-file (str "templates/" template-path) context)]
    (spit output-path content)
    (println "Generated:" output-path)))

(defn- extract-dtos-from-db! [db-spec output-dir]
  (println "Connecting to database...")
  (let [tables (jdbc/query db-spec ["SELECT table_name FROM information_schema.tables"])]
    (doseq [{:keys [table_name]} tables]
      (let [output-path (str output-dir "/" table_name ".java")
            columns (jdbc/query db-spec [(str "SELECT column_name, data_type "
                                            "FROM information_schema.columns "
                                            "WHERE table_name = '" table_name "'")])]
        (render-and-save! "java/dto.selmer" output-path
                         {:className (str/capitalize table_name)
                          :columns columns})))))

(defn -main [& args]
  (let [config (-> (first args) slurp edn/read-string)]
    (case (:mode config)
      :filesystem
      (doseq [{:keys [template target context]} (:files config)]
        (let [full-context (merge config context)
              output-path (str (:output-dir config "generated") "/" target)]
          (create-directories! output-path)
          (render-and-save! template output-path full-context)))

      :database
      (extract-dtos-from-db! (:db config)
                            (:output-dir config "generated-dtos")))))
