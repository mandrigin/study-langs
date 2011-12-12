(define (make-account balance password)
  (let ((wrong-calls 0))
      (define (call-the-cops)
        (error "Cops arrested you!"))
      (define (password-protect func)
        (lambda (p val)
          (if (eq? p password)
            (begin (reset-wrong) (func val))
            (begin (inc-wrong) "Wrong pass!"))))
      (define (inc-wrong)
        (if (>= wrong-calls 7)
          (call-the-cops)
          (set! wrong-calls (+ wrong-calls 1))))
      (define (reset-wrong)
        (set! wrong-calls 0))
      (define (withdraw amount)
        (if (>= balance amount)
          (begin (set! balance (- balance amount)) balance)
          "No money -- no honey!"))
      (define (deposit amount)
        (begin (set! balance (+ balance amount)) balance))
      (define (dispatch m)
        (cond ((eq? m `withdraw) (password-protect withdraw))
              ((eq? m `deposit) (password-protect deposit))
              (else (error "Unknown call -- MAKE-ACCOUNT" m))))
      dispatch))


(define acc (make-account 100 `secret))

((acc `withdraw) `secret 30)

((acc `withdraw) `secret 150)

((acc `deposit) `sec 170)
((acc `deposit) `secret 170)

((acc `withdraw) `unsec 150)

((acc `withdraw) `secret 150)
((acc `withdraw) `unsec 150)
((acc `withdraw) `unsec 150)
((acc `withdraw) `unsec 150)
((acc `withdraw) `unsec 150)
((acc `withdraw) `unsec 150)
((acc `withdraw) `unsec 150)
((acc `withdraw) `unsec 150)
((acc `withdraw) `unsec 150)