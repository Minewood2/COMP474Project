; Set of fish entries (F)
; Fish Advisor
; Group Chen-Ambayec (group ID: 360204)
; COMP 474
; February 20, 2026

(deffacts fish-entries

   (fish (name "Neon Tetra")
         (min-ph 4.0) (max-ph 7.5) (min-temp 21) (max-temp 25) (tank-size-req 10) (hardness 18)
         (temperament peaceful)
         (behavior schooling))

   (fish (name "Cherry Barbs")
         (min-ph 6.0) (max-ph 8.0) (min-temp 20) (max-temp 27) (tank-size-req 10) (hardness 36)
         (temperament peaceful)
         (behavior schooling))

   (fish (name "Betta splendens (male)")
         (min-ph 6.0) (max-ph 8.0) (min-temp 22) (max-temp 30) (tank-size-req 3) (hardness 18)
         (temperament aggressive)
         (behavior territorial))

   (fish (name "Betta splendens (female)")
         (min-ph 6.0) (max-ph 8.0) (min-temp 22) (max-temp 30) (tank-size-req 3) (hardness 18)
         (temperament semi-aggressive)
         (behavior territorial))

   (fish (name "Zebra Danios")
         (min-ph 6.0) (max-ph 8.0) (min-temp 18) (max-temp 25) (tank-size-req 10) (hardness 90)
         (temperament peaceful)
         (behavior schooling))

   (fish (name "Fancy Goldfish")
         (min-ph 6.5) (max-ph 7.5) (min-temp 18) (max-temp 24) (tank-size-req 29) (hardness 71)
         (temperament peaceful)
         (behavior neither))

   (fish (name "Angelfish")
         (min-ph 6.0) (max-ph 7.4) (min-temp 24) (max-temp 30) (tank-size-req 55) (hardness 0)
         (temperament peaceful)
         (behavior neither))

   (fish (name "Panda Corydoras Catfish")
         (min-ph 6.0) (max-ph 7.4) (min-temp 23) (max-temp 25) (tank-size-req 10) (hardness 18)
         (temperament peaceful)
         (behavior schooling))

   (fish (name "Livebearers (guppies, mollies, platys)")
         (min-ph 5.5) (max-ph 8.0) (min-temp 18) (max-temp 28) (tank-size-req 5) (hardness 179)
         (temperament peaceful)
         (behavior neither))

   (fish (name "Harlequin Rasboras")
         (min-ph 5.0) (max-ph 7.5) (min-temp 21) (max-temp 28) (tank-size-req 10) (hardness 18)
         (temperament peaceful)
         (behavior schooling))

   (fish (name "Dwarf Gouramis")
         (min-ph 6.0) (max-ph 7.5) (min-temp 22) (max-temp 27) (tank-size-req 15) (hardness 36)
         (temperament semi-aggressive)
         (behavior territorial))

   (fish (name "Honey Gouramis")
         (min-ph 6.0) (max-ph 7.5) (min-temp 22) (max-temp 27) (tank-size-req 10) (hardness 36)
         (temperament peaceful)
         (behavior neither))

   (fish (name "German Blue Rams")
         (min-ph 4.0) (max-ph 7.0) (min-temp 27) (max-temp 30) (tank-size-req 10) (hardness 18)
         (temperament peaceful)
         (behavior neither))

   (fish (name "African Cichlids")
         (min-ph 7.8) (max-ph 8.6) (min-temp 24) (max-temp 29) (tank-size-req 30) (hardness 160)
         (temperament aggressive)
         (behavior territorial))

   (fish (name "Dwarf Rainbowfish")
         (min-ph 5.5) (max-ph 8.0) (min-temp 20) (max-temp 30) (tank-size-req 15) (hardness 142)
         (temperament peaceful)
         (behavior schooling))
)