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

(define-library (application-hook)
  (export make-apply-hook
          apply-hook?
          apply-hook-procedure
          set-apply-hook-procedure!
          apply-hook-extra
          set-apply-hook-extra!
          make-entity
          entity?
          entity-procedure
          set-entity-procedure!
          entity-extra
          set-entity-extra!)
  (import (scheme base)
          (srfi 229))
  (begin
    (define-record-type apply-hook-tag
      (make-apply-hook-tag procedure extra)
      apply-hook-tag?
      (procedure apply-hook-tag-procedure apply-hook-tag-set-procedure!)
      (extra apply-hook-tag-extra apply-hook-tag-set-extra!))

    (define (make-apply-hook proc obj)
      (let ((tag (make-apply-hook-tag proc obj)))
        (lambda/tag tag arg*
          (apply (apply-hook-tag-procedure tag) arg*))))

    (define (apply-hook? obj)
      (and (procedure/tag? obj)
           (apply-hook-tag? (procedure-tag obj))))

    (define (apply-hook-procedure hook)
      (apply-hook-tag-procedure (procedure-tag hook)))

    (define (set-apply-hook-procedure! hook proc)
      (apply-hook-tag-set-procedure! (procedure-tag hook) proc))

    (define (apply-hook-extra hook)
      (apply-hook-tag-extra (procedure-tag hook)))

    (define (set-apply-hook-extra! hook obj)
      (apply-hook-tag-set-extra! (procedure-tag hook) obj))

    (define-record-type entity-tag
      (make-entity-tag procedure extra)
      entity-tag?
      (procedure entity-tag-procedure entity-tag-set-procedure!)
      (extra entity-tag-extra entity-tag-set-extra!))

    (define (make-entity proc obj)
      (let ((tag (make-entity-tag proc obj)))
        (define f
          (lambda/tag tag arg*
            (apply (entity-tag-procedure tag) f arg*)))
        f))

    (define (entity? obj)
      (and (procedure/tag? obj)
           (entity-tag? (procedure-tag obj))))

    (define (entity-procedure hook)
      (entity-tag-procedure (procedure-tag hook)))

    (define (set-entity-procedure! hook proc)
      (entity-tag-set-procedure! (procedure-tag hook) proc))

    (define (entity-extra hook)
      (entity-tag-extra (procedure-tag hook)))

    (define (set-entity-extra! hook obj)
      (entity-tag-set-extra! (procedure-tag hook) obj))))
