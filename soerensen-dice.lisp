(in-package #:vas-string-metrics)

(defun seq-cdr (sequence)
  (make-array (1- (array-dimension sequence 0))
              :element-type (array-element-type sequence)
              :displaced-to sequence
              :displaced-index-offset 1))

(defun bigrams (string)
  (flet ((contains-space-p (gram)
           (find #\Space gram)))
    (remove-if #'contains-space-p
               (loop for char1 across string
                  for char2 across (seq-cdr string)
                  collect (format nil "~C~C" char1 char2)))))

(defun soerensen-dice-coefficient (string1 string2)
  (let ((string1-bigrams (bigrams (string-downcase string1)))
        (string2-bigrams (bigrams (string-downcase string2))))
    (float (/ (* 2 (length (intersection string1-bigrams string2-bigrams :test #'string=)))
              (+ (length string1-bigrams) (length string2-bigrams))))))
