(in-package :cl-user)
(defpackage run-app-once-asd
  (:use :cl :asdf))
(in-package :run-app-once-asd)

(defsystem run-app-once
  :name "run-app-once"
  :author "Alexey Veretennikov <alexey.veretennikov@protonmail.com>"
  :description "Run only one instance of the delivered by LispWorks application"
  :components 
  ((:file "package")
   #+win32(:file "run-app-once-win32")
   #+linux (:file "run-app-once-linux")))
