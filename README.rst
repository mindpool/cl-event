########
cl-event
########

General Usage
*************

To make use of ``cl-event``, you will need to:

#. pull in the code

#. define a callback

#. open a stream

#. decide whether to use the XXX or the YYY approach, and then use it ;-)

#. use the XXX approach:

   #. initialize libevent

   #. create an event object

   #. associate the event with a callback and stream

   #. add the event to the event-base

#. use the YYY approach

   #. collaps all of that into a single call

#. start the main loop


Getting Set Up
==============
.. code:: lisp

    (in-package :event)
    (defun my-callback (s)
      ...)

    (defvar s ( ... open stream ... ))


Usage Approaches
================

Functions
+++++++++

.. code:: lisp

    ;; initialize libevent
    (event-init)
    ;; create an instance of an event
    (defvar e (make-instance 'event))
    ;; associate event with a callback and a stream
    (event-set e s i
        (make-flags :ev-persist t)
        'my-callback s)
    ;; add event to libevent event-base
    (event-add e)


Objects
+++++++

or this way:
consider we have a CLOS object containing a stream and other stuff called ``c``
and a method called ``READ-CONNECTION`` that takes a connection object as
argument.

.. code:: lisp

    (add-event-callback (connection-stream c)
      (make-flags :ev-persist t)
      'read-connection c)
    (event-dispatch)

Kicking off the event loop:

.. code:: lisp

    ;; main loop of libevent, calls my-callback whenever there is anything to
    ;; read on s
    (event-dispatch)


Examples
********

With the general usage out of the way, we are now ready to tackle some actual
examples.

Timeout
-------

.. code:: lisp



Socket
------

.. code:: lisp


Signals
-------

.. code:: lisp

    (in-package :event)

    (defun signal-callback (data)
      (format t "~a" data)
      ;; unsupported (event-abort))

    (defun timeout-callback (message)
      (format t "~a" message)
      ;; unsupported (event-abort))



    (defvar s ( ... open stream ... ))
