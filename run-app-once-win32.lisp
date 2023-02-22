(in-package :run-app-once)

(defconstant error-already-exists 183)

(fli:define-foreign-function (create-mutex "CreateMutexW")
    ((lp-mutex-attributes :pointer)
     (b-initial-owner win32:bool)
     (lpname :pointer))
  :result-type win32:handle)

(fli:define-foreign-function (release-mutex "ReleaseMutex")
    ((h-mutex win32:handle))
  :result-type win32:bool)

(defun create-mutex-win32 (name)
  (fli:with-foreign-string (new-ptr element-count byte-count 
                                      :external-format :unicode)
        name
      (declare (ignore element-count byte-count))
      (create-mutex fli:*null-pointer* 1 new-ptr)))

(defun app-already-running-p (unique-app-name)
  "Check if the app is already running"
  (let* ((mutex (create-mutex-win32 unique-app-name))
         (already-running (eq (win32:get-last-error) error-already-exists)))
    (unless (zerop mutex)
      (release-mutex mutex))
    already-running))
    