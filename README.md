lunit
=====

A lightweight Lisp unit testing library. This is... a work in progress.

### Example

```lisp
(load (merge-pathnames "fixtures/calculator" *load-truename*))
(use-package :calculator)
(load (merge-pathnames "../src/lunit" *load-truename*))
(use-package :lunit)

(create-suite "calculator" (lambda (suite)
  (setup suite (lambda ()
    (calculator:reset)
  ))

  (test suite "should add correctly" (lambda ()
    (assert (= 0 (calculator:value)))
    (calculator:add 5)
    (assert (= 5 (calculator:value)))
    (calculator:add 5)
    (assert (= 10 (calculator:value)))
  ))

  (test suite "reset should set accumulator to 0" (lambda ()
    (assert (= 0 (calculator:value)))
    (calculator:add 2)
    (assert (/= 0 (calculator:value)))
    (calculator:reset)
    (assert (= 0 (calculator:value)))
  ))

  (test suite "assertion fail" (lambda ()
    (assert (= 1 (calculator:value)))
  ))
))
```
