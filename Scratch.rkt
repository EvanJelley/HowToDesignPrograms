;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Scratch) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; 3.6 - World Programs

; Exercise 39
(define SCALAR 10)

; Exercise 41 - Scenery
(define tree
  (underlay/xy (circle (* 2 SCALAR) "solid" "green")
               (* 1.8 SCALAR) (* 3 SCALAR)
               (rectangle (/ SCALAR 2) (* 4 SCALAR) "solid" "brown")))

(define WIDTH-OF-WORLD (* SCALAR 120))
(define HEIGHT-OF-WORLD (* SCALAR 10))
(define mt (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))
(define BACKGROUND
  (place-image tree (/ WIDTH-OF-WORLD 3) (- HEIGHT-OF-WORLD (* SCALAR 1.1)) mt))

(define WHEEL-RADIUS SCALAR)
(define WHEEL-DISTANCE (* SCALAR 1.25))

(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))
(define SPACE
  (rectangle SCALAR 0 "solid" "white"))
(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))
(define CAR-BODY-HEIGHT (* SCALAR 3))
(define CAR-WIDTH (* SCALAR 7))
(define CAR-HEIGHT (+ CAR-BODY-HEIGHT SCALAR))
(define CAR-BODY
  (rectangle CAR-WIDTH (* WHEEL-RADIUS 2) "solid" "red"))
(define CAR-TOP
  (rectangle (/ CAR-WIDTH 2) CAR-BODY-HEIGHT "solid" "red"))
(define CAR-MAIN
  (overlay/align "middle" "bottom" CAR-BODY CAR-TOP))
(define CAR
  (overlay/offset BOTH-WHEELS 0 (* SCALAR -1.25) CAR-MAIN))
(define Y-CAR
  (- HEIGHT-OF-WORLD (/ CAR-HEIGHT 2)))
(define SPEED (/ SCALAR 2))


; REVISED FOR MOUSE CLICK INTERUPTS
; WorldState Number Number String -> WorldState
; places the car at x-mouse
; if the given me is "button-down"
(define (hyper x-position-of-car x-mouse y-mouse me)
  (cond
    [(string=? "button-down" me) x-mouse]
    [else x-position-of-car]))

; WorldState -> Image
; places the image of the car x pixels from 
; the left margin of the BACKGROUND image 
(define (render x)
  (place-image CAR x
               Y-CAR BACKGROUND))
 
; WorldState -> WorldState
; adds 3 to x to move the car right 
(define (tock x)
  (+ x SPEED))

; Exercise 42
; WorldState -> Boolean
; returns false when the cw + CAR-WIDTH/2 is > WIDTH-OF-WORLD
(define (finish world)
  (> world (+ WIDTH-OF-WORLD (/ CAR-WIDTH 2))))

; Exercise 40
(check-expect (tock 20) 23)
(check-expect (tock 78) 81)

; WorldState -> WorldState
; launches the program from some initial state 
(define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]
     [on-mouse hyper]
     [stop-when finish]))

(main 13)