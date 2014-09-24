#lang racket
(provide gen-users)

;; gen-users
;; (listof (fullname email)) -> void
;; given a list of grader names and email addresses, generate an initial
;; users.rtkd. Every user has a default password of "password"
(define (gen-users ls)
 (let ([users (with-input-from-file "grades-server/users.rktd" read)])
   (with-output-to-file
     "grades-server/users.rktd"
     (thunk
       (pretty-write (append (map (lambda (p)
                        ;; "password"
                  (let* ([pass "5f4dcc3b5aa765d61d8327deb882cf99"]
                         [name (car p)]
                         [email (cadr p)]
                         [user (string->symbol (car (string-split email "@")))])
                        `(,user (,pass ,name ,email)))) ls)
                             users)))
     #:exists 'replace)))

(gen-users (with-input-from-file "graders.rkt" read))