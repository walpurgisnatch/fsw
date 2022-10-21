(in-package :cl-user)
(defpackage fsw
  (:use :cl
   :fsw.utils)
  (:export :pwd
   :ls
   :mkdir
   :rmdir
   :cd
   :ls-files
   :ls-directories
   :search-for
   :rmfile
   :exists
   :exists-here))

(in-package :fsw)

(cl-reexport:reexport-from :fsw.utils)

(defun pwd ()
  (uiop/os:getcwd))

(defun cd (&optional directory)
  (uiop:chdir (or directory "~/")))

(defun ls (&optional directory)
  (let ((dir (or directory (pwd))))
    (when (wild-pathname-p dir)
      (error "Wildcard not supported"))
    (directory (directory-wildcard dir))))

(defun ls-files (&optional directory)
  (uiop:directory-files (or directory (pwd))))

(defun ls-directories (&optional directory)
  (uiop:subdirectories (or directory (pwd))))

(defun search-for (item &optional directory)
  (remove-if-not (lambda (x)
                   (search item
                           (subseq (namestring x)
                                   (1+ (position #\/ (namestring x))))))
                 (ls directory)))

(defun mkdir (dir &optional parent)
  (namestring (ensure-directories-exist
               (if parent
                   (merge-with-dir dir parent)
                   (pathname-as-directory dir)))))

(defun rmdir (path)
  (uiop:delete-directory-tree (pathname (pathname-as-directory path)) :validate t))

(defun rmfile (file)
  (uiop:delete-file-if-exists (pathname file)))

(defun exists (item)
  (or (uiop:file-exists-p item) (uiop:directory-exists-p item)))

(defun exists-here (item)
  (setf item (merge-with-dir item (pwd)))
  (or (uiop:file-exists-p item) (uiop:directory-exists-p item)))
