;; implementing a binary tree using cons-list form as follows
; (node rootValue
;     (node leftValue
;         (nil)
;         (nil))
;     (node rightValue
;         (nil)
;         (nil))
; )
(: Tree (-> $a Type))
(: nil (Tree $a))
(: node (-> $a (Tree $a) (Tree $a) (Tree $a)))


(: insertNode (-> $a (Tree $a) (Tree $a) ))
(= (insertNode $x nil)
    (empty)
)
(= (insertNode $y (node $x nil (node $z $h $j)))
    (node $x (node $y nil nil) (node $z $h $j))
)
(= (insertNode $y (node $x (node $z $h $j) nil))
    (node $x (node $z $h $j) (node $y nil nil))
)
(= (insertNode $y (node $x $xL $xR))
    (if (>= $y $x)
        (node $x $xL (insertNode $y $xR))
        (node $x (insertNode $y $xL) $xR)
    )
)

!(insertNode 4 (node 5 (node 3 nil nil) nil))


(: find (-> $a (Tree $a) (Tree $a)))
(= (find $y nil)
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

; !(find 3 (node 4 (node 3 (node 2 nil nil) nil) nil))