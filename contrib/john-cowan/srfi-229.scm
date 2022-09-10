;;;; Native Chicken implementation of SRFI 229

;; Copyright (C) John Cowan (2022).  All Rights Reserved.

;; Permission is hereby granted, free of charge, to any person
;; obtaining a copy of this software and associated documentation
;; files (the "Software"), to deal in the Software without
;; restriction, including without limitation the rights to use, copy,
;; modify, merge, publish, distribute, sublicense, and/or sell copies
;; of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
;; BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
;; ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
;; CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

(module srfi-229 (
  case-lambda/tag
  lambda/tag
  procedure/tag?
  procedure-tag)

  (import scheme chicken.base chicken.memory.representation)

    (define-syntax case-lambda/tag
      (syntax-rules ()
	((case-lambda/tag expr (formals body1 ... body2) ...)
	 (extend-procedure
	  (case-lambda (formals body1 ... body2) ...)
          expr))))

    (define-syntax lambda/tag
      (syntax-rules ()
	((lambda/tag expr formals body1 ... body2)
	 (extend-procedure
	  (lambda formals body1 ... body2)
          expr))))

    (define procedure/tag?
      extended-procedure?)
    (define procedure-tag
      procedure-data)
)
