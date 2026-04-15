; Fish Advisor Rules
; Fish Advisor
; Group Chen-Ambayec (group ID: 360204)
; COMP 474
; April 15, 2026


; Rule 1: likely beginner-friendly
(defrule cf-beginner-friendly
   (fish-cf (name ?n) (beginner-friendly-cf ?cf))
   (test (>= ?cf 0.75))
   =>
   (assert (cf-conclusion
      (fish-name ?n)
      (hypothesis beginner-friendly)
      (cf ?cf)
      (explanation "This species is likely beginner-friendly.")))
)


; Rule 2: likely not beginner-friendly
(defrule cf-not-beginner-friendly
   (fish-cf (name ?n) (beginner-friendly-cf ?cf))
   (test (< ?cf 0.50))
   =>
   (assert (cf-conclusion
      (fish-name ?n)
      (hypothesis not-beginner-friendly)
      (cf (- 1 ?cf))
      (explanation "This species is likely difficult for beginners.")))
)


; Rule 3: likely good for peaceful community
(defrule cf-peaceful-community-good
   (fish-cf (name ?n) (peaceful-community-cf ?cf))
   (test (>= ?cf 0.75))
   =>
   (assert (cf-conclusion
      (fish-name ?n)
      (hypothesis peaceful-community-good)
      (cf ?cf)
      (explanation "This species is likely suitable for peaceful community aquariums.")))
)


; Rule 4: likely poor for peaceful community
(defrule cf-peaceful-community-poor
   (fish-cf (name ?n) (peaceful-community-cf ?cf))
   (test (< ?cf 0.40))
   =>
   (assert (cf-conclusion
      (fish-name ?n)
      (hypothesis peaceful-community-poor)
      (cf (- 1 ?cf))
      (explanation "This species is likely unsuitable for peaceful community aquariums.")))
)


; Rule 5: highly sensitive species
(defrule cf-high-sensitivity
   (fish-cf (name ?n) (sensitivity-cf ?cf))
   (test (>= ?cf 0.80))
   =>
   (assert (cf-conclusion
      (fish-name ?n)
      (hypothesis highly-sensitive)
      (cf ?cf)
      (explanation "This species is highly sensitive to unstable conditions.")))
)


; Rule 6: likely good in small tanks
(defrule cf-small-tank-success
   (user (tank-size ?ts))
   (test (<= ?ts 10))
   (fish-cf (name ?n) (small-tank-success-cf ?cf))
   (test (>= ?cf 0.70))
   =>
   (assert (cf-conclusion
      (fish-name ?n)
      (hypothesis small-tank-likely-success)
      (cf ?cf)
      (explanation "This species is likely to do well in a small aquarium.")))
)

; Rule 7: likely poor in small tanks
(defrule cf-small-tank-risk
   (user (tank-size ?ts))
   (test (<= ?ts 10))
   (fish-cf (name ?n) (small-tank-success-cf ?cf))
   (test (< ?cf 0.50))
   =>
   (assert (cf-conclusion
      (fish-name ?n)
      (hypothesis small-tank-risk)
      (cf (- 1 ?cf))
      (explanation "This species is unlikely to thrive in a small aquarium.")))
)


; Rule 8: high territorial risk
(defrule cf-high-territorial-risk
   (fish-cf (name ?n) (territorial-risk-cf ?cf))
   (test (>= ?cf 0.80))
   =>
   (assert (cf-conclusion
      (fish-name ?n)
      (hypothesis high-territorial-risk)
      (cf ?cf)
      (explanation "This species has a high likelihood of territorial conflict.")))
)


; Rule 9: risky for peaceful preference
(defrule cf-risky-for-peaceful-user
   (user (temperament-wanted peaceful))
   (fish-cf (name ?n) (territorial-risk-cf ?cf))
   (test (>= ?cf 0.70))
   =>
   (assert (cf-conclusion
      (fish-name ?n)
      (hypothesis risky-for-peaceful-user)
      (cf ?cf)
      (explanation "This species is likely risky for a peaceful aquarium.")))
)


; Rule 10: candidate but sensitive
(defrule cf-candidate-sensitive-warning
   (candidate (fish-name ?n))
   (fish-cf (name ?n) (sensitivity-cf ?cf))
   (test (>= ?cf 0.80))
   =>
   (assert (cf-conclusion
      (fish-name ?n)
      (hypothesis compatible-but-sensitive)
      (cf ?cf)
      (explanation "This species may be compatible, but it is highly sensitive.")))
)


; Rule 11: High-confidence CF recommendation
(defrule cf-high-confidence
   (candidate (fish-name ?n))
   (fish-cf (name ?n)
            (beginner-friendly-cf ?b)
            (peaceful-community-cf ?p)
            (sensitivity-cf ?s))
   =>
   (bind ?score (/ (+ ?b ?p (- 1 ?s)) 3.0))
   (if (>= ?score 0.75) then
      (assert
         (cf-recommendation
            (fish-name ?n)
            (score ?score)
            (label high-confidence)
            (explanation "High certainty-factor recommendation."))))
)


; Rule 12: Medium-confidence CF recommendation
(defrule cf-medium-confidence
   (candidate (fish-name ?n))
   (fish-cf (name ?n)
            (beginner-friendly-cf ?b)
            (peaceful-community-cf ?p)
            (sensitivity-cf ?s))
   =>
   (bind ?score (/ (+ ?b ?p (- 1 ?s)) 3.0))
   (if (and (>= ?score 0.50) (< ?score 0.75)) then
      (assert
         (cf-recommendation
            (fish-name ?n)
            (score ?score)
            (label medium-confidence)
            (explanation "Moderate certainty-factor recommendation."))))
)


; Rule 13: Low-confidence CF recommendation
(defrule cf-low-confidence
   (candidate (fish-name ?n))
   (fish-cf (name ?n)
            (beginner-friendly-cf ?b)
            (peaceful-community-cf ?p)
            (sensitivity-cf ?s))
   =>
   (bind ?score (/ (+ ?b ?p (- 1 ?s)) 3.0))
   (if (< ?score 0.50) then
      (assert
         (cf-recommendation
            (fish-name ?n)
            (score ?score)
            (label low-confidence)
            (explanation "Low certainty-factor recommendation."))))
)



(defrule print-cf-header
   (declare (salience -60))
   (cf-recommendation)
   (not (printed-cf-results))
   =>
   (printout t "=== Certainty Factor Recommendations ===" crlf crlf)
   (assert (printed-cf-results))
)

(defrule print-cf-item
   (declare (salience -61))
   (cf-recommendation
      (fish-name ?n)
      (score ?s)
      (label ?l)
      (explanation ?e))
   =>
   (printout t "- " ?n
               " -> "
               ?l
               " recommendation"
               " (CF score = "
               ?s
               ")"
               crlf
               "  Reason: "
               ?e
               crlf)
)