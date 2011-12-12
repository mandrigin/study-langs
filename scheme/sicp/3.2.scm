(define (make-monitored func)
  (let ((calls 0))
    (define (reset-count)
      (set! calls 0))
    (define (how-many-calls?)
      calls)
    (define (inc-calls)
      (set! calls (+ calls 1)))
    (define (mf value)
      (cond ((eq? value `reset-count)
             (reset-count))
            ((eq? value `how-many-calls?)
             (how-many-calls?))
            (else (begin (inc-calls) (func value)))))
    mf))


(define (square val) (* val val))

(define mi (make-monitored square))

(mi 10)

(mi 20)

(mi 4)

(mi `how-many-calls?)

(mi `reset-count)

(mi `how-many-calls?)

(mi 4)

(mi `how-many-calls?))
