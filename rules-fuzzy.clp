; Fish Advisor Rules
; Fish Advisor
; Group Chen-Ambayec (group ID: 360204)
; COMP 474
; April 15, 2026

; Fuzzy Rule 1: Tank very small
(defrule fuzzify-tank-very-small
   (user (tank-size ?t))
   (test (<= ?t 5))
   =>
   (assert (fuzzy-category (variable tank-size) (label very-small) (degree 1.0)))
)

; Fuzzy Rule 2: Tank small
(defrule fuzzify-tank-small
   (user (tank-size ?t))
   (test (and (> ?t 5) (<= ?t 15)))
   =>
   (assert (fuzzy-category (variable tank-size) (label small) (degree 0.8)))
)

; Fuzzy Rule 3: Tank medium
(defrule fuzzify-tank-medium
   (user (tank-size ?t))
   (test (and (> ?t 15) (<= ?t 30)))
   =>
   (assert (fuzzy-category (variable tank-size) (label medium) (degree 0.8)))
)

; Fuzzy Rule 4: Tank Large
(defrule fuzzify-tank-large
   (user (tank-size ?t))
   (test (> ?t 30))
   =>
   (assert (fuzzy-category (variable tank-size) (label large) (degree 1.0)))
)

; Fuzzy Rule 5: Hardness soft
(defrule fuzzify-hardness-soft
   (user (hardness ?h))
   (test (< ?h 75))
   =>
   (assert (fuzzy-category (variable hardness) (label soft) (degree 0.9)))
)

; Fuzzy Rule 6: Hardness moderate
(defrule fuzzify-hardness-moderate
   (user (hardness ?h))
   (test (and (>= ?h 75) (<= ?h 150)))
   =>
   (assert (fuzzy-category (variable hardness) (label moderate) (degree 0.8)))
)

; Fuzzy Rule 7: Hardness Hard
(defrule fuzzify-hardness-hard
   (user (hardness ?h))
   (test (> ?h 150))
   =>
   (assert (fuzzy-category (variable hardness) (label hard) (degree 0.9)))
)

; Fuzzy Rule 8: Temp cool
(defrule fuzzify-temperature-cool
   (user (temp ?t))
   (test (< ?t 24))
   =>
   (assert (fuzzy-category (variable temperature) (label cool) (degree 0.8)))
)

; Fuzzy Rule 9: Temp ideal
(defrule fuzzify-temperature-ideal
   (user (temp ?t))
   (test (and (>= ?t 24) (<= ?t 27)))
   =>
   (assert (fuzzy-category (variable temperature) (label ideal) (degree 0.9)))
)

; Fuzzy Rule 10: Temp warm
(defrule fuzzify-temperature-warm
   (user (temp ?t))
   (test (> ?t 27))
   =>
   (assert (fuzzy-category (variable temperature) (label warm) (degree 0.8)))
)

; Fuzzy Rule 11: Very Small Aquarium 
(defrule fuzzy-excellent-nano-choice
   (candidate (fish-name ?n))
   (fuzzy-category (variable tank-size) (label very-small) (degree ?d1))
   (fish-fuzzy (name ?n) (nano-degree ?d2) (aggression-degree ?a))
   (test (and (>= ?d1 0.8) (>= ?d2 0.75) (< ?a 0.5)))
   =>
   (assert
      (fuzzy-recommendation
         (fish-name ?n)
         (suitability excellent)
         (degree ?d2)
         (explanation "Excellent fuzzy match for a very small aquarium.")))
)

; Fuzzy Rule 12: Small Aquarium 
(defrule fuzzy-good-small-tank-choice
   (candidate (fish-name ?n))
   (fuzzy-category (variable tank-size) (label small) (degree ?d1))
   (fish-fuzzy (name ?n) (small-tank-degree ?d2) (aggression-degree ?a))
   (test (and (>= ?d1 0.7) (>= ?d2 0.70) (< ?a 0.6)))
   =>
   (assert
      (fuzzy-recommendation
         (fish-name ?n)
         (suitability good)
         (degree ?d2)
         (explanation "Good fuzzy match for a small aquarium.")))
)

; Fuzzy Rule 13: Peaceful
(defrule fuzzy-good-peaceful-community
   (candidate (fish-name ?n))
   (user (temperament-wanted peaceful))
   (fish-fuzzy (name ?n) (community-degree ?c) (aggression-degree ?a))
   (test (and (>= ?c 0.75) (< ?a 0.4)))
   =>
   (assert
      (fuzzy-recommendation
         (fish-name ?n)
         (suitability good)
         (degree ?c)
         (explanation "Good fuzzy match for a peaceful community aquarium.")))
)


; Fuzzy Rule 14: Hig sensitivity 
(defrule fuzzy-fair-sensitive-choice
   (candidate (fish-name ?n))
   (fish-fuzzy (name ?n) (community-degree ?c) (sensitivity-degree ?s))
   (test (and (>= ?c 0.60) (>= ?s 0.70)))
   =>
   (assert
      (fuzzy-recommendation
         (fish-name ?n)
         (suitability fair)
         (degree 0.50)
         (explanation "May fit the aquarium, but high sensitivity reduces fuzzy suitability.")))
)

; Fuzzy Rule 15: Agressive
(defrule fuzzy-poor-peaceful-match
   (candidate (fish-name ?n))
   (user (temperament-wanted peaceful))
   (fish-fuzzy (name ?n) (aggression-degree ?a))
   (test (>= ?a 0.75))
   =>
   (assert
      (fuzzy-recommendation
         (fish-name ?n)
         (suitability poor)
         (degree ?a)
         (explanation "Poor fuzzy match for a peaceful aquarium because of aggression.")))
)

; Fuzzy Rule 16: Beginner Friendly
(defrule fuzzy-good-beginner-choice
   (candidate (fish-name ?n))
   (fish-fuzzy (name ?n) (beginner-degree ?b) (sensitivity-degree ?s))
   (test (and (>= ?b 0.75) (< ?s 0.5)))
   =>
   (assert
      (fuzzy-recommendation
         (fish-name ?n)
         (suitability good)
         (degree ?b)
         (explanation "Good fuzzy match for a beginner aquarist.")))
)

; Fuzzy Rule 17: Beginner Unfriendly
(defrule fuzzy-poor-beginner-choice
   (candidate (fish-name ?n))
   (fish-fuzzy (name ?n) (beginner-degree ?b))
   (test (< ?b 0.40))
   =>
   (assert
      (fuzzy-recommendation
         (fish-name ?n)
         (suitability poor)
         (degree (- 1 ?b))
         (explanation "Poor fuzzy match for a beginner aquarist.")))
)

; Fuzzy Rule 18: Good Hard water

(defrule fuzzy-good-hard-water-fit
   (candidate (fish-name ?n))
   (fuzzy-category (variable hardness) (label hard) (degree ?d))
   (test (or (eq ?n "African Cichlids")
             (eq ?n "Livebearers (guppies, mollies, platys)")))
   =>
   (assert
      (fuzzy-recommendation
         (fish-name ?n)
         (suitability good)
         (degree ?d)
         (explanation "Good fuzzy fit for harder water.")))
)

; Fuzzy Rule 19: Bad Hard water
(defrule fuzzy-poor-hard-water-fit
   (candidate (fish-name ?n))
   (fuzzy-category (variable hardness) (label hard) (degree ?d))
   (test (or (eq ?n "Neon Tetra")
             (eq ?n "German Blue Rams")
             (eq ?n "Harlequin Rasboras")))
   =>
   (assert
      (fuzzy-recommendation
         (fish-name ?n)
         (suitability poor)
         (degree ?d)
         (explanation "Poor fuzzy fit for harder water.")))
)

; Fuzzy Rule 20: Good Temp range
(defrule fuzzy-ideal-temp-fit
   (candidate (fish-name ?n))
   (fuzzy-category (variable temperature) (label ideal) (degree ?d))
   (fish-fuzzy (name ?n) (community-degree ?c))
   (test (>= ?c 0.60))
   =>
   (assert
      (fuzzy-recommendation
         (fish-name ?n)
         (suitability good)
         (degree ?d)
         (explanation "Good fuzzy fit for the selected temperature range.")))
)

; Print header once
(defrule print-fuzzy-header
   (declare (salience -70))
   (fuzzy-recommendation)
   (not (printed-fuzzy-results))
   =>
   (printout t crlf "=== Fuzzy Logic Recommendations ===" crlf crlf)
   (assert (printed-fuzzy-results))
)


; Start one fish block at a time
(defrule start-fuzzy-fish-block
   (declare (salience -71))
   (printed-fuzzy-results)
   (not (current-fuzzy-fish (fish-name ?x)))
   (fuzzy-recommendation (fish-name ?n))
   (not (fuzzy-print-done (fish-name ?n)))
   =>
   (printout t "Fish: " ?n crlf)
   (assert (current-fuzzy-fish (fish-name ?n)))
)


; Print recommendation lines only for the current fish
(defrule print-fuzzy-item-line
   (declare (salience -72))
   (current-fuzzy-fish (fish-name ?n))
   (fuzzy-recommendation
      (fish-name ?n)
      (suitability ?s)
      (degree ?d)
      (explanation ?e))
   (not (fuzzy-item-printed (fish-name ?n) (explanation ?e)))
   =>
   (printout t
      "  - "
      ?s
      " ("
      ?d
      "): "
      ?e
      crlf)
   (assert (fuzzy-item-printed (fish-name ?n) (explanation ?e)))
)


; Close the current fish block when all its lines are printed
(defrule end-fuzzy-fish-block
   (declare (salience -73))
   ?c <- (current-fuzzy-fish (fish-name ?n))
   (not (and
         (fuzzy-recommendation (fish-name ?n) (explanation ?e))
         (not (fuzzy-item-printed (fish-name ?n) (explanation ?e)))))
   =>
   (printout t crlf)
   (assert (fuzzy-print-done (fish-name ?n)))
   (retract ?c)
)


; Final footer after all fish blocks are done
(defrule print-fuzzy-footer
   (declare (salience -74))
   (printed-fuzzy-results)
   (not (current-fuzzy-fish (fish-name ?x)))
   (not (and
         (fuzzy-recommendation (fish-name ?n))
         (not (fuzzy-print-done (fish-name ?n)))))
   =>
   (printout t
      "Fuzzy suitability expresses degree of fit rather than strict yes/no logic."
      crlf crlf)
)