# Run application delivered application in one instance
Usage example:
```
(defparameter *my-app-name* "a_rather_unique_app_name")
(defun main-ui ()
  (unless (run-app-once:app-already-running-p app-name)
    (capi:display (make-instance 'my-app))))
```
