(in-package #:vas-string-metrics)

(defun levenshtein-distance (s1 s2)
  "Finds the Levenshtein distance (minimum number of edits) from string s1 to string s2."
  (let ((previous-row (make-array (list (1+ (length s1)))))
        (current-row (make-array (list (1+ (length s1))))))
    (dotimes (i (length previous-row))
      (setf (aref previous-row i) i))
    (loop for r from 1 below (1+ (length s2)) do
         (loop for c from 1 below (1+ (length s1)) do
              (setf (aref current-row 0) r
                    (aref current-row c) (min (1+ (aref previous-row c))
                                              (1+ (aref current-row (1- c)))
                                              (+ (if (equalp (aref s1 (1- c)) (aref s2 (1- r))) 0 1)
                                                 (aref previous-row (1- c))))))
         (rotatef previous-row current-row))
    (aref previous-row (1- (length previous-row)))))

(defun normalized-levenshtein-distance (s1 s2)
  "Finds the normalized Levenshtein distance (from 0 for no similarity
to 1 for exact match) from string s1 to string s2."
  (- 1 (/ (levenshtein-distance s1 s2) (max (length s1) (length s2)))))
