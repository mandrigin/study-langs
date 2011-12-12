(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
            (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))


(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low 
       (/ (random (* range 10000)) 10000) )))
         

  

(define (estimate-integral P x1 y1 x2 y2 trials)
  (define (point-test)
    (P (random-in-range x1 x2) (random-in-range y1 y2)))
  (* (* (- x2 x1) (- y2 y1)) (monte-carlo trials point-test)))

(define (circle x y radius)
  (lambda (xa ya)
    (<= (+ (square (- xa x))
           (square (- ya y)))
        (square radius))))

(define (circle-three x y)
  ((circle 5 7 3) x y))

(define (circle-one x y)
  ((circle 0 0 1) x y))
           

(/ (estimate-integral circle-three 2 4 8 10 100000) 9.0)
