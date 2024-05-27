;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Scratch) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; 3.6 - World Programs

; Exercise 39
(define SCALAR 5)

; Exercise 41 - Scenery
(define tree
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))

(define WIDTH-OF-WORLD (* SCALAR 120))
(define HEIGHT-OF-WORLD (* SCALAR 10))
(define mt (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))
(define BACKGROUND
  (place-image tree (/ WIDTH-OF-WORLD 3) (- HEIGHT-OF-WORLD 7) mt))

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


; A WorldState is a Number.
; interpretation the number of pixels between
; the left border of the scene and the car

; WorldState -> Image
; places the image of the car x pixels from 
; the left margin of the BACKGROUND image 
(define (render x)
  (place-image CAR (+ (/ CAR-WIDTH 2) x)
               (- HEIGHT-OF-WORLD (/ CAR-HEIGHT 2)) BACKGROUND))
 
; WorldState -> WorldState
; adds 3 to x to move the car right 
(define (tock x)
  (+ x 3))

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
     [stop-when finish]))

(main 13)