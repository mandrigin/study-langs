(define (improve y x)
  (/ (+ (/ x (* y y) ) (* 2 y) ) 3)
  )


(define (good-enough? guess x)
  (< (/ (abs (- guess (improve guess x) ) ) guess ) 0.0001 )
  )

(define (cube-root-iter guess x)
  (if (good-enough? guess x)
      guess
      (cube-root-iter (improve guess x) x)
      )
  )

(define (cube-root x)
  (cube-root-iter 1.0 x)
  )
