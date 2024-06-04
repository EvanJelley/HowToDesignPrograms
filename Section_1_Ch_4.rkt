;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Section_1_Ch_4) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define (reward s)
  (cond
    [(<= 0 s 10) "bronze"]
    [(and (< 10 s) (<= s 20)) "silver"]
    [else "gold"]))

; Exercise 48
; (reward 18)

; Exercise 49
; (define y 100)
; (define y 210)
; (- 200 (cond [(> y 200) 0] [else y]))

; Exercise 50
; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")
(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

; Exercise 51
(define (LIGHT color)
  (circle 30 "solid" color))
(define MT
  (empty-scene 100 100))
(define (TRAFFIC-LIGHT-SCENE color)
  (place-image (LIGHT color) 50 50 MT))

(define (traffic-animation ws)
  (big-bang ws
    [on-tick traffic-light-next 1]
    [to-draw TRAFFIC-LIGHT-SCENE]))

(traffic-animation "red")