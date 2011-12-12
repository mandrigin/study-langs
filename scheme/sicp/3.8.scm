(define (check-sub func)
  (let ((was-called 0))
    (define (f arg)
      (if (> was-called 0)
        0
        (begin (set! was-called 1) arg)))
    (func (f 0) (f 1))))

(define (plus arg1 arg2) (+ arg2 arg1))

(check-sub +)
(check-sub plus)
