(defpackage :lunit
  (:use :common-lisp)
  (:export :create-suite)
)
(in-package :lunit)

(defun create-suite (name callback)
  (let ((asuite (make-instance 'suite :name name)))
    (onstart)
    ; Test will register all setup, test, and teardown hooks here.
    (funcall callback asuite)
    (dolist (atest (tests asuite))
      ; Run setup routines.
      (dolist (asetup (setups asuite)) (funcall asetup))
      (setf (passed asuite) (+ 1 (passed asuite)))
      (onpass)
      (funcall (fn atest))
      ; Run teardown routines.
      (dolist (ateardown (teardowns asuite)) (funcall ateardown))
    )
    (onend asuite)
  )
)

(defun setup (asuite fn)
  (setf
    (setups asuite)
    (cons fn (setups asuite))
  )
)

(defun test (asuite name fn)
  (setf
    (tests asuite)
    (cons (make-instance 'testcase :name name :fn fn) (tests asuite))
  )
)

(defun teardown (asuite fn)
  (setf
    (teardowns asuite)
    (cons fn (teardowns asuite))
  )
)

(defclass suite ()
  ((name
     :initarg :name
     :reader name)
   (setups
     :initform nil
     :accessor setups)
   (tests
     :initform nil
     :accessor tests)
   (teardowns
     :initform nil
     :accessor teardowns)
   (passed
     :initform 0
     :accessor passed)
   (failed
     :initform 0
     :accessor failed)
  )
)

(defclass testcase ()
  ((name
     :initarg :name
     :reader name)
   (fn
     :initarg :fn
     :reader fn)
  )
)

; Reporter stuff
(defun onstart ()
  (format t "~%")
)

(defun onpass ()
  (format t ".")
)

(defun onend (asuite)
  (format t "~%~%")
  (format t "~D passed~%" (passed asuite))
  (format t "~D failed~%" (failed asuite))
)
