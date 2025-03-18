 ; put you code here
(Person M)
(Person_name (Person M) Monica)
(Person_gender (Person M) female)

(Person C)
(Person_name (Person C) Chandler)
(Person_gender (Person C) male)

(Person J)
(Person_name (Person J) John)
(Person_gender (Person J) male)

(Person P)
(Person_name (Person P) Pam)
(Person_gender (Person P) female)

(Person A)
(Person_name (Person A) Adam)
(Person_gender (Person A) male)

(Person Ja)
(Person_name (Person Ja) Jane)
(Person_gender (Person Ja) female)

(Person B)
(Person_name (Person B) Bob)
(Person_gender (Person B) male)

(Person T)
(Person_name (Person T) Tim)
(Person_gender (Person T) male)

(Person K)
(Person_name (Person K) Kim)
(Person_gender (Person K) female)

(Person E)
(Person_name (Person E) Eve)
(Person_gender (Person E) female)

(Person Jo)
(Person_name (Person Jo) Joey)
(Person_gender (Person Jo) male)

(Parent C J)
(Parent C P)
(Parent C A)
(Parent C Ja)

(Parent M J)
(Parent M P)
(Parent M A)
(Parent M Ja)

(Parent J B)
(Parent P K)
(Parent P T)
(Parent A E)
(Parent Ja Jo)

 ;Parents of John
; ! (match &self (, (Parent $x J) (Person_name (Person $x) $y)) ($y is the parent of John)) ; Parents of john
;  ;Mother of Pam
; ! (match &self
;     (,
;         (Parent $x P)
;         (Person_gender (Person $x) female)
;         (Person_name (Person $x) $y)
;     )
; ($y is the Mother of Pam)
; )
;  ; siblings of Pam
; ! (match &self
;     (,
;         (Parent M $x)
;         (Person_name (Person $x) $i)
;     )
; (if (== $i Pam) [] ($i is a sibling of Pam))
; )
;  ; Method 1 of getting the uncle of Tim
;  ; By directly accessing the data of the grandparent
; ! (match &self
;     (,
;         (Parent C $x)
;         (Person_gender (Person $x) male)
;         (Person_name (Person $x) $y)
;     )
; ($y is the uncle of Tim)
; )
;  ; Method 2 of getting the uncle of Tim
;  ; Working my way back from Tim to the uncles
; ! (match &self
;     (,
;         (Parent $x T)
;         (Parent $y $x)
;         (Parent $y $i)
;         (Person_gender (Person $i) male)
;         (Person_name (Person $i) $j)
;     )
; ($j is the uncle of Tim)
; )
;  ; Method 1 of getting the nephews of John
; ! (match &self
;     (,
;         (Parent P $x)
;         (Parent Ja $y)
;         (Person_gender (Person $x) male)
;         (Person_gender (Person $y) male)
;         (Person_name (Person $x) $i)
;         (Person_name (Person $y) $j)
;     )
; ($i and $j are the nephews of John)
; )
;  ; Method 2 of getting the nephews of john
; ! (match &self
;     (,
;         (Parent $x J)
;         (Parent $x $y)
;         (Parent $y $i)
;         (Person_gender (Person $i) male)
;         (Person_name (Person $i) $j)
;     )
; (if (== $y J) [] ($j is the nephew of John))
; )
 ; Getting the predecessors of Bob
; ! (match &self
;     (,
;         (Parent $x B)
;         (Parent $y $x)
;         (Person_name (Person $x) $i)
;         (Person_name (Person $y) $j)
;     )
; ($i and $j are the Predecessors of Bob)
; )

(= (get_uncle $node)
    (if (== $node ())
        ()
        (match &self (,
                    (Parent $x $node)
                    (Parent $y $x)
                    (Person_gender (Person $y) male)
                    (Parent $y $z)
                    (Person_gender (Person $z) male)
                    (Person_name (Person $z) $u)
                    )
                    (if (== $z $x) (empty) $u)
        ))
)

; !(get_uncle B)

(= (get_aunt $node)
    (if (== $node ())
        ()
        (match &self (,
                    (Parent $x $node)
                    (Parent $y $x)
                    (Person_gender (Person $y) male)
                    (Parent $y $z)
                    (Person_gender (Person $z) female)
                    (Person_name (Person $z) $a)
                    )
                    (if (== $z $x) () $a)
        ))
)

; !(get_aunt B)