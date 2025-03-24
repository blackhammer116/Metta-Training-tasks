;; implementing a binary tree using cons-list form as follows
; (node rootValue
;     (node leftValue
;         (nil)
;         (nil))
;     (node rightValue
;         (nil)
;         (nil))
; )
(: nil (empty))
(: node Tree)

(: insertNode (-> Number node node))
(= (insertNode $x (nil))
    (empty)
)
(= (insertNode $y (node $x (nil) $xR))
    ; (empty)
    (node $x (node $y (nil) (nil)) $xR)
)
(= (insertNode $y (node $x $xL (nil)))
    (node $x $xL (node $y (nil) (nil)))
    ; (empty)
)
(= (insertNode $y (node $x $xL $xR))
    (if (>= $y $x)
        (node $x $xL (insertNode $y $xR))
        (node $x (insertNode $y $xL) $xR)
    )
)

; !(insertNode 5 (node 4 (node 3 (nil) (nil)) (nil)))


(: find (-> Number node Expression))
(= (find $y (nil))
    ("Error $y not In tree")
)
(= (find $y (node $x $xL $xR))
    (if (== $y $x)
        (Found at: (node $x $xL $xR))
        (if (< $y $x)
            (find $y $xL)
            (find $y $xR)
        )
    )
)

!(find 3 (node 4 (node 3 (node 2 (nil) (nil)) (nil)) (nil)))