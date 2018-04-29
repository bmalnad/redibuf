;; redibuf - A project template generated by ahungry-fleece
;; Copyright (C) 2016 Your Name <redibuf@example.com>
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU Affero General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU Affero General Public License for more details.
;;
;; You should have received a copy of the GNU Affero General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;;; redibuf.lib.math.lisp

(in-package #:cl-user)

(defpackage redibuf.lib.math
  (:use
   :cl
   :redis

   ;; cl-protobufs
   :protobufs
   )
  (:export
   :math
   ))

(in-package #:redibuf.lib.math)

(defun schema-parse ()
  "Load up a cl-protobufs schema file."
  (protobufs:parse-schema-from-file
   "~/src/lisp/redibuf/math.proto"
   :name 'math
   :class 'math
   :conc-name nil))

(defun schema-to-string (protobuf-schema)
  "Given a cl-protobufs schema, write it to a string stream."
  (let ((schema (make-array '(0) :element-type 'base-char
                            :fill-pointer 0 :adjustable t)))
    (with-output-to-string (s schema)
      (proto:write-schema protobuf-schema :type :lisp :stream s))
    schema))

(defun schema-eval (spec)
  "Read/evaluate all the things in a string."
  (loop for (s-exp pos) = (multiple-value-list (read-from-string spec nil 'eof :start (or pos 0)))
     until (eq s-exp 'eof)
     do (progn
          (print pos)
          (eval s-exp))))

(defun schema-boot ()
  "Load all the things."
  (schema-eval (schema-to-string (schema-parse)))
  (cl:in-package :redibuf.lib.math)
  (rename-package :tutorial :tutorial '(:nicknames :pbt)))

(schema-boot)

;;; "redibuf.lib.math" goes here. Hacks and glory await!
