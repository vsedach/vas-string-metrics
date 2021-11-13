(in-package #:vas-string-metrics)

(defun levenshtein-distance (s1 s2
                             &key
                               (test #'equalp) ; case insensitive
                               (key #'identity))
  "Finds the Levenshtein distance (minimum number of edits) from string s1 to string s2."
  (let* ((s1len (length s1))
         (s2len (length s2))
         (buf (make-array s1len
                          :element-type 'integer
                          :initial-element 0))
         (prev 0))
    (loop
       for i below s1len
       do (setf (aref buf i) (1+ i)))
    (loop
       for row below s2len
       do
         (let* ((col 0)
                (dist
                 (if (funcall test
                              (funcall key (aref s1 col))
                              (funcall key (aref s2 row)))
                     row
                     (1+ (min row
                              (aref buf col))))))
           (setf prev dist))
         (loop
            for col from 1 below s1len
            do
              (let* ((dist
                      (if (funcall test
                                   (funcall key (aref s1 col))
                                   (funcall key (aref s2 row)))
                          (aref buf (1- col))
                          (1+ (min prev
                                   (aref buf (1- col))
                                   (aref buf col))))))
                (setf (aref buf (1- col))
                      prev)
                (setf prev dist)))
         (setf (aref buf (1- s1len)) prev))
    prev))

(defun normalized-levenshtein-distance (s1 s2)
  "Finds the normalized Levenshtein distance (from 0 for no similarity
to 1 for exact match) from string s1 to string s2."
  (- 1 (/ (levenshtein-distance s1 s2) (max (length s1) (length s2)))))
