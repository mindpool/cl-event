(require 'asdf)
(asdf:operate 'asdf:load-op :cl-event)
(asdf:operate 'asdf:load-op :usocket)

(in-package :event)

(defun set-sock1 ()
  (setf sock1 (usocket:socket-stream (usocket:socket-connect "localhost" 1234))))

(defun set-sock2 ()
  (setf sock2 (usocket:socket-stream (usocket:socket-connect "localhost" 1235))))



(defun add-stream (st)
  (setf e (make-instance 'event))
  (event-set e st (make-flags :ev-persist t) (lambda (sock) (format t "Read:~a~%" (read-line sock))) st)
  (event-add e))


(defun new-add-stream (st)
  (add-event-callback st (make-flags :ev-persist t)
                      (lambda (sock)
                        (format t "Readededed :~a~%" (read-line sock))
                        (format sock "Stuff~%")) st))

(defun add-stream1 ()
  (add-stream sock1))

(defun add-stream2 ()
  (add-stream sock2))

;;; now the test part
(event-init)
(set-sock1)
(set-sock2)
;(add-stream1)
;(add-stream2)
(new-add-stream sock1)
(new-add-stream sock2)
(event-dispatch)
