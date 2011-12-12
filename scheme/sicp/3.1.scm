(define (make-accumulator init)
  (lambda (add)
    (begin (set! init (+ init add)) init)))


(define z (make-accumulator 0))

(z 10)

(z 20)

(z 1)
