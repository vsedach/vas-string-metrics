(asdf:defsystem :vas-string-metrics
  :name "vas-string-metrics"
  :description "Jaro-Winkler and Levenshtein string distance algorithms."
  :author "Vladimir Sedach <vsedach@gmail.com>"
  :license "LLGPLv3"
  :components ((:file "package")
               (:file "levenshtein" :depends-on ("package"))
               (:file "jaro-winkler" :depends-on ("package"))
               (:file "soerensen-dice" :depends-on ("package"))))
