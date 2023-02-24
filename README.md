# Run only one delivered LispWorks application
Works only on Windows and Linux

Usage example:
```
(defparameter *my-app-name* "a_rather_unique_app_name")

(defun main-ui ()
  (unless (run-app-once:app-already-running-p *my-app-name*)
    (capi:display (make-instance 'my-app))))
```
