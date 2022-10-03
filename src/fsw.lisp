(in-package :cl-user)
(defpackage fsw
  (:use :cl
   :fsw.utils)
  (:export :pwd
   :ls
   :mkdir))

(in-package :fsw)

(cl-reexport:reexport-from :fsw.utils)

(defun pwd ()
  (uiop/os:getcwd))

(defun ls (&optional directory)
  (let ((dir (or directory ".")))
    (when (wild-pathname-p dir)
      (error "Wildcard not supported"))
    (directory (directory-wildcard dir))))

(defun mkdir (dir &optional parent)
  (namestring (ensure-directories-exist
               (if parent
                   (merge-with-dir dir parent)
                   (pathname-as-directory dir)))))
