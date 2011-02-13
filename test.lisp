;; Copying and distribution of this file, with or without
;; modification, are permitted in any medium without royalty provided
;; this notice is preserved. This file is offered as-is, without any
;; warranty.

(in-package #:vas-string-metrics)

(defun run-tests ()
  "Run vas-string-metrics unit tests. Signals assertion failure on
failed test. Returns nil if all tests pass."
  (assert (= 17/18 (jaro-distance "martha" "marhta")))
  (assert (< 0.961 (jaro-winkler-distance "martha" "marhta") 0.962))
  (assert (= 37/45 (jaro-distance "dwayne" "duane")))
  (assert (< 0.84 (jaro-winkler-distance "dwayne" "duane") 0.845))
  (assert (= 23/30 (jaro-distance "dixon" "dicksonx")))
  (assert (< 0.81 (jaro-winkler-distance "dixon" "dicksonx") 0.82))

  (assert (= 0 (jaro-distance "abc" "xyz")))
  (assert (= 1 (jaro-distance "foobar" "foobar")))
  (assert (= 0 (jaro-winkler-distance "abc" "xyz")))
  (assert (= 1 (jaro-winkler-distance "foobar" "foobar")))

  (assert (= 3 (levenshtein-distance "sitting" "kitten")))
  (assert (= 3 (levenshtein-distance "Sunday" "Saturday")))
  (assert (= 2 (levenshtein-distance "gambol" "gumbo")))
  (assert (= 0 (normalized-levenshtein-distance "abc" "xyz")))
  (assert (= 1 (normalized-levenshtein-distance "foobar" "foobar"))))

(export 'run-tests)
