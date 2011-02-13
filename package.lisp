(cl:defpackage #:vas-string-metrics
  (:use #:cl)
  (:export #:jaro-distance
           #:jaro-winkler-distance
           #:levenshtein-distance
           #:normalized-levenshtein-distance))
