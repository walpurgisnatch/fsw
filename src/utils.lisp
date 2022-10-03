(in-package :cl-user)
(defpackage fsw.utils
  (:use :cl)
  (:export :directory-wildcard
           :directory-pathname-p
           :pathname-as-directory
           :dirp
           :upper-directory
           :merge-with-dir))

(in-package :fsw.utils)

(defun string-starts-with (string x)
  (string-equal string x :end1 (length x)))

(defun directory-wildcard (dir)
  (make-pathname
   :name :wild
   :type :wild
   :defaults (pathname-as-directory dir)))

(defun component-present-p (value)
  (and value (not (eql value :unspecific))))

(defun directory-pathname-p  (p)
  (and
   (not (component-present-p (pathname-name p)))
   (not (component-present-p (pathname-type p)))
   p))

(defun pathname-as-directory (name)
  (let ((pathname (pathname name)))
    (when (wild-pathname-p pathname)
      (error "Can't reliably convert wild pathnames."))
    (if (not (directory-pathname-p name))
        (make-pathname
         :directory (append (or (pathname-directory pathname) (list :relative))
                            (list (file-namestring pathname)))
         :name      nil
         :type      nil
         :defaults pathname)
        pathname)))

(defun dirp (path)
  (find #\/ path))

(defun upper-directory (&optional directory)
  (elt (nth-value 1 (cl-ppcre:scan-to-strings "(.*/).+$" (namestring (or directory (uiop/os:getcwd))))) 0))

(defun merge-with-dir (child parent)
  (merge-pathnames child (pathname-as-directory parent)))
