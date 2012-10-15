(require 'asdf)
(asdf:operate 'asdf:load-op :cl-event)
(ql:quickload "usocket")
(ql:quickload "xlunit")

;(in-package :event)

(defpackage #:event-tests
  (:use #:cl #:xlunit #:event)
  (:export #:event-test-suite))

(in-package #:event-tests)

(defclass file-test-case (test-case)
  ()
  (:documentation "Exercise the functionality of local fds in libevent"))

(def-test-method test-read ((test file-test-case) :run nil)
  ;--- TODO (oubiwann@mindpool.io): define a callback for once the file is
  ;                                 read; the callback should have the assert
  ;                                 in it
  ;--- TODO (oubiwann@mindpool.io): get a pipe or something similar for lisp
  ;--- TODO (oubiwann@mindpool.io): create an event with the cb and the fd,
  ;                                 seeing the event type as EV_READ
  ;--- TODO (oubiwann@mindpool.io): write text to the pipe
  ;--- TODO (oubiwann@mindpool.io): call event-dispatch
  (assert-true (= 5 5)))

(textui-test-run (get-suite file-test-case))
