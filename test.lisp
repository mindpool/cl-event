(require 'asdf)
(asdf:operate 'asdf:load-op :cl-event)
(ql:quickload "usocket")
(ql:quickload "xlunit")
(ql:quickload "osicat")


(defpackage #:event-tests
  ;(:use #:cl #:xlunit #:event #:osicat)
  (:export #:event-test-suite))


(in-package #:event-tests)


(defclass file-test-case (test-case)
  ()
  (:documentation "Exercise the functionality of local fds in libevent"))


(def-test-method test-read ((test file-test-case) :run nil)
  ; create a temp stream for the test
  (osicat:with-temporary-file (stream)

    ; check the result of the data written to the stream
    (defun handle-write (stream)
      (let ((data (read-line stream)))
      (assert-equal data "XXX")))

    ; initialize the event loop
    (event:event-init)
    ; create an event instance
    (defvar test-event (make-instance 'event:event))
    ; associate an event with our callback and our stream
    (event:event-set test-event stream
      (event:make-flags :ev-persist t)
      'handle-write
      stream)

    ;--- TODO (oubiwann@mindpool.io): write text to the stream
    (format stream "this is a test")

    ; start up the event loop for libevent
    (event:event-dispatch))

  ;--- TODO: delete this next line once the rest of the test is working
  (assert-true (= 5 5)))


(textui-test-run (get-suite file-test-case))
