;; Copyright (C) Marc Nieper-Wißkirchen (2021).  All Rights Reserved.

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

(import (scheme base)
	(srfi 64)
	(application-hook))

(test-begin "Application Hooks")

(define h (make-apply-hook (lambda (x) (* x x)) 42))

(test-eqv #t (apply-hook? h))
(test-eqv 4 (h 2))
(test-eqv 9 ((apply-hook-procedure h) 3))

(set-apply-hook-procedure! h (lambda (x) (* x x x)))
(test-eqv 27 (h 3))

(test-eqv 42 (apply-hook-extra h))

(set-apply-hook-extra! h 43)
(test-eqv 43 (apply-hook-extra h))

(define e (make-entity (lambda (e x) (+ (entity-extra e) x)) 42))

(test-eqv #t (entity? e))
(test-eqv 44 (e 2))
(test-eqv 45 ((entity-procedure e) e 3))

(set-entity-procedure! e (lambda (e x) (* (entity-extra e) x)))
(test-eqv 126 (e 3))

(test-eqv 42 (entity-extra e))

(set-entity-extra! e 43)
(test-eqv 43 (entity-extra e))
(test-eqv 86 (e 2))

(test-end)
