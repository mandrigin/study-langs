(define (len lst)
  (define (_len lst val)
    (if (null? lst) val (_len (cdr lst) (+ val 1))))
  (_len lst 0))

(define (variable? x) (symbol? x))

(define (same-variable? x y)
  (and (variable? x) (variable? y) (eq? x y)))

(define (make-sum x y) 
  (cond ((=number? x 0) y)
        ((=number? y 0) x)
        ((and (number? x) (number? y)) (+ x y))
        (else (list '+ x y))))

(define (make-product x y) 
  (cond ((or (=number? x 0) (=number? y 0)) 0)
        ((=number? x 1) y)
        ((=number? y 1) x)
        ((and (number? x) (number? y)) (* x y))
        (else (list '* x y))))

(define (_action? x sym)
  (and (pair? x) (eq? (car x) sym)))

(define (sum? x) (_action? x '+))
(define (product? x) (_action? x '*))
(define (exponentiation? x) (_action? x '**))

(define (make-exponentiation b e)
  (cond ((= e 0) 1)
        ((= e 1) b)
        (else (list '** b e))))

(define (base x) (cadr x))
(define (exponent x) (caddr x))


(define (addend x) (cadr x))
(define (augend x) 
  (define (create_sum args)
    (cond ((= (len args) 0) 0)
          ((= (len args) 1) (car args))
          (else (make-sum (car args) (create_sum(cdr args))))))
  (create_sum (caddr x)))


(define (multiplier x) (cadr x))
(define (multiplicant x) (caddr x))

(define (=number? x y)
  (and (number? x) (= x y)))


(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicant exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicant exp))))
        ((exponentiation? exp)
         (make-product
           (exponent exp)
           (make-product
             (make-exponentiation (base exp) (- (exponent exp) 1))
             (deriv (base exp) var))))
        (else (error "Unknow expression type - DERIV" exp))))

(len '(1 2 3))
(deriv '(** x 2) 'x)
(deriv '(+ x x x) 'x)
