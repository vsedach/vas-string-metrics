(in-package #:vas-string-metrics)

(defun matching-char-list (s1 s2)
  (flet ((make-indexed-list (cs) (loop for i = 0 then (incf i) for c across cs collect (cons c i))))
    (let ((c1s (make-indexed-list s1))
          (c2s (make-indexed-list s2))
          (max-char-window (- (floor (max (length s1) (length s2)) 2) 1))
          (matching-chars ()))
      (loop for (c . i) in c1s do
           (let ((matching-char (car (remove-if-not (lambda (c2)
                                                      (and (char= c (car c2))
                                                           (<= (abs (- i (cdr c2))) max-char-window)))
                                                    c2s))))
             (when matching-char
               (push (cdr matching-char) matching-chars)
               (setf c2s (remove matching-char c2s)))))
      matching-chars)))

(defun jaro-distance (s1 s2)
  "Finds the Jaro distance (measure of similarity) from string s1
to string s2. Returns a value in the range from 0 (no similarity) to
1 (exact match)."
  (let* ((matching-chars (matching-char-list s1 s2))
         (m (length matching-chars))
         (num-transpositions (/ (reduce '+ (mapcar (lambda (x y) (if (= x y) 0 1)) matching-chars (sort (copy-seq matching-chars) '>))) 2)))
    (if (= 0 m)
        0
        (/ (+ (/ m (length s1))
              (/ m (length s2))
              (/ (- m num-transpositions) m))
           3))))

(defun prefix-length (s1 s2)
  (loop for c1 across s1
        for c2 across s2
        unless (char= c1 c2) do (loop-finish)
        count c1))

(defun jaro-winkler-distance (s1 s2)
  "Finds the Jaro distance (measure of similarity) from string s1
to string s2. Returns a value in the range from 0 (no similarity) to
1 (exact match)."
  (let ((jd (jaro-distance s1 s2)))
    (+ jd (* 0.1 (min 4 (prefix-length s1 s2)) (- 1 jd)))))
