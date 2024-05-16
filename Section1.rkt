;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Section1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Exercise 1
(define x 12)
(define y 5)

; Distance Calc
(sqrt (+ (* x x) (* y y)))

; Exercise 2
(define prefix "hello")
(define suffix "world")

(string-append prefix "_" suffix)

; Exercise 3 & 4
(define str "helloworld")
(define i 5)

(string-append (substring str 0 i) "_" (substring str i 10))

(string-append (substring str 0 i) (substring str (+ i 1) (string-length str)))

