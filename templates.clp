; Fish and user templates
; Fish Advisor
; Group Chen-Ambayec (group ID: 360204)
; COMP 474
; April 15, 2026


(deftemplate fish
   (slot name)
   (slot min-ph (type FLOAT))
   (slot max-ph (type FLOAT))
   (slot min-temp (type INTEGER))
   (slot max-temp (type INTEGER))
   (slot tank-size-req (type INTEGER))
   (slot hardness (type INTEGER))
   (slot temperament (allowed-symbols peaceful semi-aggressive aggressive))
   (slot behavior (allowed-symbols schooling territorial neither))
)

(deftemplate user
   (slot ph (type FLOAT))
   (slot temp (type INTEGER))
   (slot tank-size (type INTEGER))
   (slot tank-size-cf (type FLOAT))
   (slot hardness (type INTEGER))
   (slot hardness-cf(type FLOAT))
   (slot temperament-wanted (allowed-symbols peaceful aggressive))
   (slot temperament-cf (type FLOAT))
   (slot behavior-wanted (allowed-symbols schooling territorial))
   (slot behavior-cf (type FLOAT))
)

(deftemplate incompatible
   (slot fish-name)
   (slot reason)
)

(deftemplate warning
   (slot fish-name)
   (slot reason)
)

(deftemplate candidate
   (slot fish-name)
   (slot tank-size-req (type INTEGER))
)

(deftemplate compatible-with-warning
   (slot fish-name)
)

(deftemplate suggestion
   (slot fish-name)
   (slot advice)
)


; Certainty Factors (B)

(deftemplate fish-cf
   (slot name)
   (slot beginner-friendly-cf (type FLOAT))
   (slot peaceful-community-cf (type FLOAT))
   (slot sensitivity-cf (type FLOAT))
   (slot small-tank-success-cf (type FLOAT))
   (slot territorial-risk-cf (type FLOAT))
)

(deftemplate cf-conclusion
   (slot fish-name)
   (slot hypothesis)
   (slot cf (type FLOAT))
   (slot explanation)
)

(deftemplate cf-recommendation
   (slot fish-name)
   (slot score (type FLOAT))
   (slot label)
   (slot explanation)
)

(deftemplate cf-attribute-score
   (slot fish-name)
   (slot attribute)
   (slot evidence (type FLOAT))
   (slot rule-cf (type FLOAT))
   (slot score (type FLOAT))
   (slot explanation)
)

(deftemplate cf-final-average
   (slot fish-name)
   (slot average (type FLOAT))
)

(deftemplate cf-final-label
   (slot fish-name)
   (slot label)
)

(deftemplate printed-cf-results)


; Fuzzy-style knowledge
(deftemplate fish-fuzzy
   (slot name)
   (slot nano-degree (type FLOAT))
   (slot small-tank-degree (type FLOAT))
   (slot community-degree (type FLOAT))
   (slot beginner-degree (type FLOAT))
   (slot aggression-degree (type FLOAT))
   (slot sensitivity-degree (type FLOAT))
)

(deftemplate fuzzy-category
   (slot variable)
   (slot label)
   (slot degree (type FLOAT))
)

(deftemplate fuzzy-recommendation
   (slot fish-name)
   (slot suitability)
   (slot degree (type FLOAT))
   (slot explanation)
)

(deftemplate printed-fuzzy-results)
(deftemplate current-fuzzy-fish
   (slot fish-name)
)
(deftemplate fuzzy-print-done
   (slot fish-name)
)
(deftemplate fuzzy-item-printed
   (slot fish-name)
   (slot explanation)
)


(deftemplate printed-recommendations)
(deftemplate printed-warnings)
(deftemplate printed-incompatible)
(deftemplate printed-suggestions)
(deftemplate printed-no-results)
