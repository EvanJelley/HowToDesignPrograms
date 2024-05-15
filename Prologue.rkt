;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Prologue) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; constants 
(define WIDTH  100)
(define HEIGHT  60)
(define V 3)

(define MTSCN  (empty-scene WIDTH HEIGHT "blue"))
(define ROCKET (overlay (circle 10 "solid" "green")
         (rectangle 40 4 "solid" "green")))
(define ROCKET-CENTER-TO-TOP
  (- HEIGHT (/ (image-height ROCKET) 2)))
(define MIDDLE-OF-SCENE (/ WIDTH 2))

; functions
(define (rocketAnimation t)
  (cond
    [(<= (distance t) ROCKET-CENTER-TO-TOP)
     (place-image ROCKET MIDDLE-OF-SCENE (distance t) MTSCN)]
    [(> (distance t) ROCKET-CENTER-TO-TOP)
     (place-image ROCKET MIDDLE-OF-SCENE ROCKET-CENTER-TO-TOP MTSCN)]))

(define (distance t) (* V t))

(animate rocketAnimation)
