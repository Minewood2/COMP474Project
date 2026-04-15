; Fish Advisor Rules
; Fish Advisor
; Group Chen-Ambayec (group ID: 360204)
; COMP 474
; April 15, 2026



; Rule 1: beginner-friendly score
(defrule cf-score-beginner-friendly
   (candidate (fish-name ?n))
   (fish-cf (name ?n) (beginner-friendly-cf ?rule))
   (not (cf-attribute-score (fish-name ?n) (attribute beginner-friendly)))
   =>
   (bind ?evidence 1.0)
   (bind ?score (* ?evidence ?rule))

   (assert (cf-attribute-score
      (fish-name ?n)
      (attribute beginner-friendly)
      (evidence ?evidence)
      (rule-cf ?rule)
      (score ?score)))
)


; Rule 2: peaceful-community score (peaceful user)
(defrule cf-score-peaceful-community-peaceful
   (candidate (fish-name ?n))
   (user (temperament-wanted peaceful) (temperament-cf ?evidence))
   (fish-cf (name ?n) (peaceful-community-cf ?rule))
   (not (cf-attribute-score (fish-name ?n) (attribute peaceful-community)))
   =>
   (bind ?score (* ?evidence ?rule))

   (assert (cf-attribute-score
      (fish-name ?n)
      (attribute peaceful-community)
      (evidence ?evidence)
      (rule-cf ?rule)
      (score ?score)))
)


; Rule 3: peaceful-community score (aggressive user)
(defrule cf-score-peaceful-community-aggressive
   (candidate (fish-name ?n))
   (user (temperament-wanted aggressive) (temperament-cf ?evidence))
   (fish-cf (name ?n) (peaceful-community-cf ?raw))
   (not (cf-attribute-score (fish-name ?n) (attribute peaceful-community)))
   =>
   (bind ?rule (- 0 ?raw))
   (bind ?score (* ?evidence ?rule))

   (assert (cf-attribute-score
      (fish-name ?n)
      (attribute peaceful-community)
      (evidence ?evidence)
      (rule-cf ?rule)
      (score ?score)))
)


; Rule 4: sensitivity score (negative factor)
(defrule cf-score-sensitivity
   (candidate (fish-name ?n))
   (user (tank-size-cf ?tscf) (hardness-cf ?hcf))
   (fish-cf (name ?n) (sensitivity-cf ?raw))
   (not (cf-attribute-score (fish-name ?n) (attribute sensitivity)))
   =>
   (bind ?evidence (/ (+ ?tscf ?hcf) 2.0))
   (bind ?rule (- 0 ?raw))
   (bind ?score (* ?evidence ?rule))

   (assert (cf-attribute-score
      (fish-name ?n)
      (attribute sensitivity)
      (evidence ?evidence)
      (rule-cf ?rule)
      (score ?score)))
)


; Rule 5: small-tank-success score
(defrule cf-score-small-tank-success
   (candidate (fish-name ?n))
   (user (tank-size-cf ?evidence))
   (fish-cf (name ?n) (small-tank-success-cf ?rule))
   (not (cf-attribute-score (fish-name ?n) (attribute small-tank-success)))
   =>
   (bind ?score (* ?evidence ?rule))

   (assert (cf-attribute-score
      (fish-name ?n)
      (attribute small-tank-success)
      (evidence ?evidence)
      (rule-cf ?rule)
      (score ?score)))
)


; Rule 6: territorial-risk score (territorial user)
(defrule cf-score-territorial-risk-territorial
   (candidate (fish-name ?n))
   (user (behavior-wanted territorial) (behavior-cf ?evidence))
   (fish-cf (name ?n) (territorial-risk-cf ?rule))
   (not (cf-attribute-score (fish-name ?n) (attribute territorial-risk)))
   =>
   (bind ?score (* ?evidence ?rule))

   (assert (cf-attribute-score
      (fish-name ?n)
      (attribute territorial-risk)
      (evidence ?evidence)
      (rule-cf ?rule)
      (score ?score)))
)


; Rule 7: territorial-risk score (schooling user)
(defrule cf-score-territorial-risk-schooling
   (candidate (fish-name ?n))
   (user (behavior-wanted schooling) (behavior-cf ?evidence))
   (fish-cf (name ?n) (territorial-risk-cf ?raw))
   (not (cf-attribute-score (fish-name ?n) (attribute territorial-risk)))
   =>
   (bind ?rule (- 0 ?raw))
   (bind ?score (* ?evidence ?rule))

   (assert (cf-attribute-score
      (fish-name ?n)
      (attribute territorial-risk)
      (evidence ?evidence)
      (rule-cf ?rule)
      (score ?score)))
)


; Rule 8: compute final average CF
(defrule cf-final-average-rule
   (candidate (fish-name ?n))
   (cf-attribute-score (fish-name ?n) (attribute beginner-friendly) (score ?s1))
   (cf-attribute-score (fish-name ?n) (attribute peaceful-community) (score ?s2))
   (cf-attribute-score (fish-name ?n) (attribute sensitivity) (score ?s3))
   (cf-attribute-score (fish-name ?n) (attribute small-tank-success) (score ?s4))
   (cf-attribute-score (fish-name ?n) (attribute territorial-risk) (score ?s5))
   (not (cf-final-average (fish-name ?n)))
   =>
   (bind ?avg (/ (+ ?s1 ?s2 ?s3 ?s4 ?s5) 5.0))

   (assert (cf-final-average
      (fish-name ?n)
      (average ?avg)))
)


; Rule 9: assign high-confidence label
(defrule cf-label-high
   (cf-final-average (fish-name ?n) (average ?avg))
   (test (>= ?avg 0.5))
   (not (cf-final-label (fish-name ?n)))
   =>
   (assert (cf-final-label (fish-name ?n) (label high-confidence)))
)


; Rule 10: assign medium-confidence label
(defrule cf-label-medium
   (cf-final-average (fish-name ?n) (average ?avg))
   (test (and (>= ?avg 0.0) (< ?avg 0.5)))
   (not (cf-final-label (fish-name ?n)))
   =>
   (assert (cf-final-label (fish-name ?n) (label medium-confidence)))
)


; Rule 11: assign low-confidence label
(defrule cf-label-low
   (cf-final-average (fish-name ?n) (average ?avg))
   (test (< ?avg 0.0))
   (not (cf-final-label (fish-name ?n)))
   =>
   (assert (cf-final-label (fish-name ?n) (label low-confidence)))
)



; Print header once
(defrule print-cf-header
   (declare (salience -60))
   (cf-final-average)
   (not (printed-cf-results))
   =>
   (printout t crlf "=== CF Scores for Compatible Fish ===" crlf crlf)
   (assert (printed-cf-results))
)


; Print one neat block per fish
(defrule print-cf-block
   (declare (salience -61))

   (cf-final-average (fish-name ?n) (average ?avg))
   (cf-final-label (fish-name ?n) (label ?label))

   (cf-attribute-score
      (fish-name ?n)
      (attribute beginner-friendly)
      (evidence ?e1)
      (rule-cf ?r1)
      (score ?s1))

   (cf-attribute-score
      (fish-name ?n)
      (attribute peaceful-community)
      (evidence ?e2)
      (rule-cf ?r2)
      (score ?s2))

   (cf-attribute-score
      (fish-name ?n)
      (attribute sensitivity)
      (evidence ?e3)
      (rule-cf ?r3)
      (score ?s3))

   (cf-attribute-score
      (fish-name ?n)
      (attribute small-tank-success)
      (evidence ?e4)
      (rule-cf ?r4)
      (score ?s4))

   (cf-attribute-score
      (fish-name ?n)
      (attribute territorial-risk)
      (evidence ?e5)
      (rule-cf ?r5)
      (score ?s5))
   =>
   (printout t "Fish: " ?n crlf)
   (printout t "  beginner-friendly:  " ?e1 " * " ?r1 " = " ?s1 crlf)
   (printout t "  peaceful-community: " ?e2 " * " ?r2 " = " ?s2 crlf)
   (printout t "  sensitivity:        " ?e3 " * " ?r3 " = " ?s3 crlf)
   (printout t "  small-tank-success: " ?e4 " * " ?r4 " = " ?s4 crlf)
   (printout t "  territorial-risk:   " ?e5 " * " ?r5 " = " ?s5 crlf)
   (printout t "  ----------------------------------------" crlf)
   (printout t "  average-cf-score:   " ?avg crlf)
   (printout t "  label:              " ?label crlf crlf)
)