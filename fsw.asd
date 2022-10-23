(defsystem "fsw"
  :version "0.1.5"
  :author "Walpurgisnatch"
  :license ""
  :depends-on ("cl-ppcre"
               "cl-reexport")
  :components ((:module "src"
                :serial t
                :components
                ((:file "utils")
                 (:file "fsw"))))
  :description "")
