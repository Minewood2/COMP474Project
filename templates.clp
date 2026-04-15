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
   (slot hardness (type INTEGER))
   (slot temperament-wanted (allowed-symbols peaceful aggressive))
   (slot behavior-wanted (allowed-symbols schooling territorial))
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

(deftemplate printed-recommendations)
(deftemplate printed-warnings)
(deftemplate printed-incompatible)
(deftemplate printed-suggestions)
(deftemplate printed-no-results)
