; Fish and user templates
; Fish Advisor
; Group Chen-Ambayec (group ID: 360204)
; COMP 474
; February 20, 2026


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