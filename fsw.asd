(defsystem "fsw"
  :version "0.1.0"
  :author "Walpurgisnatch"
  :license ""
  :depends-on ("cl-ppcre"
               "cl-reexport")
  :components ((:module "src"
                :components
                :serial t
                ((:file "utils")
                 (:file "fsw"))))
  :description "")
