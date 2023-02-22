(in-package :run-app-once)

;; Operations for the flock call.
(defconstant lock-sh 1 "Shared lock.")
(defconstant lock-ex 2 "Exclusive lock.")
(defconstant lock-un 8 "Unlock.")
(defconstant lock-nb 4 "Don't block when locking.")

(defparameter *lock-file* nil)

;; Apply or remove an advisory lock, according to OPERATION,
;; on the file FD refers to.
;; extern int flock (int __fd, int __operation) __THROW;
(fli:define-foreign-function (flock "flock")
    ((fd :signed-long)
     (operation :signed-long))
     :result-type :signed-long)

(defun app-already-running-p (unique-app-name)
  "Check if the app is already running"
  (setf *lock-file* (open (concatenate 'string "/tmp/" unique-app-name ".lock")
                          :if-does-not-exist :create))
  (and *lock-file*
       (= (flock (slot-value *lock-file* 'stream::file-handle)
                  (logior lock-ex lock-nb))
          -1)))