(defpackage :calculator
  (:use :common-lisp)
  (:export :add
           :reset
           :value
  )
)
(in-package :calculator)

(let ((accumulator nil))
  (defun value ()
    accumulator
  )
  (defun reset ()
    (setq accumulator 0)
  )
  (defun add (x)
    (setq accumulator (+ accumulator x))
  )
)

