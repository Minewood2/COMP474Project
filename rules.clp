; Fish Advisor Rules
; Fish Advisor
; Group Chen-Ambayec (group ID: 360204)
; COMP 474
; April 15, 2026


(deffunction ask-user ()
   (printout t "=== Freshwater Aquarium Stocking Advisor ===" crlf crlf)

   (printout t "Enter tank size (gallons): ")
   (bind ?tank (read))

   (printout t "Enter tap water pH (e.g., 7.2): ")
   (bind ?ph (read))

   (printout t "Enter planned aquarium temperature in Celsius (e.g., 25): ")
   (bind ?temp (read))

   (printout t "Enter water hardness in ppm (e.g., 150): ")
   (bind ?hard (read))

   (printout t "Desired temperament (peaceful / aggressive): ")
   (bind ?tempPref (read))

   (printout t "Desired social behavior (schooling / territorial): ")
   (bind ?behPref (read))

   (assert
      (user
         (ph ?ph)
         (temp ?temp)
         (tank-size ?tank)
         (hardness ?hard)
         (temperament-wanted ?tempPref)
         (behavior-wanted ?behPref)))
)

(defrule initialize-user
   (not (user))
   =>
   (ask-user)
)

; Rule 1: pH lower limit
(defrule ph-too-low
   (user (ph ?uph))
   (fish (name ?n) (min-ph ?min))
   (test (< ?uph ?min))
   =>
   (assert (incompatible (fish-name ?n) (reason "pH too low for this species")))
)

; Rule 2: pH upper limit
(defrule ph-too-high
   (user (ph ?uph))
   (fish (name ?n) (max-ph ?max))
   (test (> ?uph ?max))
   =>
   (assert (incompatible (fish-name ?n) (reason "pH too high for this species")))
)

; Rule 3: Temperature too low
(defrule temp-too-low
   (user (temp ?utemp))
   (fish (name ?n) (min-temp ?tmin))
   (test (< ?utemp ?tmin))
   =>
   (assert (incompatible (fish-name ?n) (reason "Water too cold for this species")))
)

; Rule 4: Temperature too high
(defrule temp-too-high
   (user (temp ?utemp))
   (fish (name ?n) (max-temp ?tmax))
   (test (> ?utemp ?tmax))
   =>
   (assert (incompatible (fish-name ?n) (reason "Water too warm for this species")))
)

; Rule 5: Hardness check
(defrule hardness-too-soft
   (user (hardness ?uh))
   (fish (name ?n) (hardness ?fh))
   (test (< ?uh ?fh))
   =>
   (assert (incompatible (fish-name ?n)
                         (reason "Water too soft (hardness below requirement)")))
)

; Rule 6: Tank too small
(defrule tank-too-small
   (user (tank-size ?ts))
   (fish (name ?n) (tank-size-req ?treq))
   (test (< ?ts ?treq))
   =>
   (assert (incompatible (fish-name ?n) (reason "Tank too small for this species")))
)

; Rule 7: Stunt warning for large fish in small tanks (< 40 gallons)
(defrule stunt-warning-large-fish
   (user (tank-size ?ts))
   (fish (name ?n))
   (test (or (eq ?n "Fancy Goldfish")
             (eq ?n "African Cichlids")
             (eq ?n "Angelfish")))
   (test (< ?ts 40))
   =>
   (assert (warning (fish-name ?n)
                    (reason "Warning: large fish in small tank (risk of stunting)")))
)

; Rule 8: Schooling fish in very small tanks (< 20 gallons)
(defrule schooling-small-tank-warning
   (user (tank-size ?ts))
   (fish (name ?n) (behavior schooling))
   (test (< ?ts 20))
   =>
   (assert (warning (fish-name ?n)
                    (reason "Warning: schooling fish in very small tank")))
)

; Rule 9: Panda Corydoras warning in small tanks (< 20 gallons)
(defrule panda-corydoras-warning
   (user (tank-size ?ts))
   (fish (name ?n))
   (test (eq ?n "Panda Corydoras Catfish"))
   (test (< ?ts 20))
   =>
   (assert (warning (fish-name ?n)
                    (reason "Warning: Panda Corydoras prefer larger group/space")))
)

; Rule 10: Male Betta solitude
(defrule male-betta-solitude-warning
   (user)
   (fish (name ?n))
   (test (eq ?n "Betta splendens (male)"))
   =>
   (assert (warning (fish-name ?n)
                    (reason "Compatible only if kept alone (male Betta)")))
)

; Rule 11: User wants peaceful, fish is aggressive
(defrule temperament-aggressive-not-wanted
   (user (temperament-wanted peaceful))
   (fish (name ?n) (temperament aggressive))
   =>
   (assert (incompatible (fish-name ?n)
                         (reason "Aggressive temperament not suitable for peaceful community")))
)

; Rule 12: User wants aggressive, fish is peaceful
(defrule temperament-peaceful-not-wanted
   (user (temperament-wanted aggressive))
   (fish (name ?n) (temperament peaceful))
   =>
   (assert (incompatible (fish-name ?n)
                         (reason "Peaceful fish not suitable for aggressive community")))
)

; Rule 13: User wants territorial, fish is schooling
(defrule schooling-not-territorial-mismatch
   (user (behavior-wanted territorial))
   (fish (name ?n) (behavior schooling))
   =>
   (assert (incompatible (fish-name ?n)
                         (reason "Schooling behavior not desired; user wants territorial fish")))
)

; Rule 14: User wants schooling, fish is territorial
(defrule territorial-not-schooling-mismatch
   (user (behavior-wanted schooling))
   (fish (name ?n) (behavior territorial))
   =>
   (assert (incompatible (fish-name ?n)
                         (reason "Territorial behavior not desired; user wants schooling fish")))
)

; Rule 15: Aggressive temperament in very small tank (< 15 gallons)
(defrule aggressive-small-tank-warning
   (user (tank-size ?ts))
   (fish (name ?n) (temperament aggressive))
   (test (< ?ts 15))
   =>
   (assert (warning (fish-name ?n)
                    (reason "Warning: aggressive fish in very small tank")))
)

; Rule 16: candidate if no incompatible fact exists
(defrule build-candidate
   (user)
   (fish (name ?n) (tank-size-req ?treq))
   (not (incompatible (fish-name ?n)))
   (not (candidate (fish-name ?n)))
   =>
   (assert (candidate (fish-name ?n)
                      (tank-size-req ?treq)))
)

; Rule 17: German Blue Ram sensitivity warning
(defrule german-blue-ram-warning
   (user)
   (fish (name ?n))
   (test (eq ?n "German Blue Rams"))
   =>
   (assert (warning (fish-name ?n)
                    (reason "Warning: German Blue Rams are sensitive and need very stable water")))
)

; Print header once if there is at least one candidate
(defrule print-recommendations-header
   (declare (salience -10))
   (candidate)
   (not (printed-recommendations))
   =>
   (printout t crlf
               "=== Suitable Fish Species ===" crlf
               "Recommended from top to bottom in rule firing order:" crlf)
   (assert (printed-recommendations))
)

; Print each compatible fish one by one
(defrule print-recommendation-item
   (declare (salience -11))
   (candidate (fish-name ?n) (tank-size-req ?t))
   =>
   (printout t "- " ?n " (minimum tank size: " ?t " gallons)" crlf)
)

; If there are no candidates, print once
(defrule no-results
   (declare (salience -20))
   (user)
   (not (candidate))
   (not (printed-no-results))
   =>
   (printout t crlf "*** No compatible fish found. ***" crlf)
   (printout t "Consider adjusting water chemistry or using a larger aquarium." crlf crlf)
   (assert (printed-no-results))
)

; Print warning header once
(defrule print-warnings-header
   (declare (salience -30))
   (warning)
   (not (printed-warnings))
   =>
   (printout t crlf "=== Warnings / Special Considerations ===" crlf)
   (assert (printed-warnings))
)

; Print each warning one by one
(defrule print-warning-item
   (declare (salience -31))
   (warning (fish-name ?n) (reason ?r))
   =>
   (printout t "- " ?n ": " ?r crlf)
)

; Final warning note once
(defrule print-warning-footer
   (declare (salience -32))
   (printed-warnings)
   =>
   (printout t crlf
               "Some of these species may still be kept successfully but require extra care or local expert advice."
               crlf crlf)
)